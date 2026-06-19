import 'dart:async';

import 'package:condor_code/ui/navigation/route_observers.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YouTubePlayerWidget extends StatefulWidget {
  final String youtubeUrl;

  const YouTubePlayerWidget({super.key, required this.youtubeUrl});

  @override
  State<YouTubePlayerWidget> createState() => _YouTubePlayerWidgetState();
}

class _YouTubePlayerWidgetState extends State<YouTubePlayerWidget>
    with RouteAware {
  YoutubePlayerController? _controller;
  String? _videoId;
  StreamSubscription<YoutubePlayerValue>? _playerStateSub;

  /// Web: iframe eats wheel scroll. While true, we draw [PointerInterceptor] + manual wheel
  /// forwarding and a Flutter play affordance (scroll views win over bare taps on web).
  /// Cleared while [PlayerState.playing] / [PlayerState.buffering] so YouTube's own UI works.
  bool _webScrollCaptureActive = true;

  /// Tracks whether the JS/CSS injection to hide settings/CC buttons has run.
  bool _buttonsHidden = false;

  @override
  void initState() {
    super.initState();
    _initYoutubeController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    coursesBranchRouteObserver.unsubscribe(this);
    final route = ModalRoute.of(context);
    if (route is PageRoute<dynamic>) {
      coursesBranchRouteObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    coursesBranchRouteObserver.unsubscribe(this);
    _detachPlayerListeners();
    _controller?.close();
    super.dispose();
  }

  @override
  void didPushNext() {
    _pausePlayback();
  }

  @override
  void didPop() {
    _pausePlayback();
  }

  @override
  void didUpdateWidget(covariant YouTubePlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.youtubeUrl == widget.youtubeUrl) return;

    _detachPlayerListeners();
    _controller?.close();
    _webScrollCaptureActive = true;
    _buttonsHidden = false;
    _initYoutubeController();
  }

  void _detachPlayerListeners() {
    _playerStateSub?.cancel();
    _playerStateSub = null;
  }

  void _pausePlayback() {
    final c = _controller;
    if (c == null) return;
    c.pauseVideo();
  }

  void _attachPlaybackListener(YoutubePlayerController c) {
    _detachPlayerListeners();
    _playerStateSub = c.listen((YoutubePlayerValue value) {
      if (!mounted) return;
      if (!_buttonsHidden && value.playerState != PlayerState.unknown) {
        _hideYouTubeButtons(c);
      }
      final capture = _shouldCaptureWebScroll(value.playerState);
      if (_webScrollCaptureActive != capture) {
        setState(() => _webScrollCaptureActive = capture);
      }
    });
  }

  /// Injects CSS into the YouTube iframe to hide the settings and subtitles
  /// buttons. This only works on mobile webviews where same-origin policies
  /// are relaxed; on web the cross-origin iframe prevents DOM access, so we
  /// rely on an overlay widget instead.
  void _hideYouTubeButtons(YoutubePlayerController c) {
    if (_buttonsHidden || kIsWeb) return;
    _buttonsHidden = true;

    // ignore: invalid_use_of_internal_member
    c.webViewController.runJavaScript('''
      (function() {
        try {
          var iframe = document.getElementsByTagName('iframe')[0];
          if (iframe && iframe.contentWindow && iframe.contentWindow.document) {
            var doc = iframe.contentWindow.document;
            var style = doc.createElement('style');
            style.textContent =
              '.ytp-settings-button, .ytp-subtitles-button { display: none !important; }';
            if (doc.head) doc.head.appendChild(style);
          }
        } catch (e) {}
      })();
    ''');
  }

  bool _shouldCaptureWebScroll(PlayerState state) {
    return state != PlayerState.playing && state != PlayerState.buffering;
  }

  void _forwardWheelToScrollable(PointerSignalEvent signal) {
    if (signal is! PointerScrollEvent) return;
    final scrollable = Scrollable.maybeOf(context);
    if (scrollable == null) return;
    final position = scrollable.position;
    if (!position.hasPixels) return;
    final next = (position.pixels + signal.scrollDelta.dy).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );
    position.jumpTo(next.toDouble());
  }

  void _initYoutubeController() {
    _videoId = YoutubePlayerController.convertUrlToId(widget.youtubeUrl);

    if (_videoId == null) {
      debugPrint('Failed to extract videoId from: ${widget.youtubeUrl}');
      return;
    }

    final videoId = _videoId!;
    // [YoutubePlayerController.fromVideoId] uses key: videoId, so every player
    // for the same video shares one JS channel / web platform id. That causes
    // duplicate GlobalKey errors on web when multiple instances exist.
    final params = const YoutubePlayerParams(
      showControls: true,
      showFullscreenButton: true,
      mute: false,
      enableCaption: false,
      strictRelatedVideos: true,
    );
    final c = YoutubePlayerController(
      params: params,
      key: '${videoId}_${identityHashCode(this)}',
    )..cueVideoById(videoId: videoId);
    _controller = c;
    _attachPlaybackListener(c);
  }

  Widget _buildVideoSurface(BuildContext context, YoutubePlayerController controller) {
    if (!kIsWeb) {
      return YoutubePlayer(controller: controller);
    }
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      fit: StackFit.expand,
      children: [
        YoutubePlayer(
          controller: controller,
          enableFullScreenOnVerticalDrag: false,
        ),
        // Block taps on the settings and subtitles buttons on web.
        // The YouTube iframe API doesn't provide parameters to hide these,
        // and cross-origin restrictions prevent JS injection into the iframe.
        Positioned(
          right: 40,
          bottom: 0,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(width: 80, height: 48, color: Colors.transparent),
          ),
        ),
        if (_webScrollCaptureActive) ...[
          Positioned.fill(
            child: PointerInterceptor(
              intercepting: true,
              child: Listener(
                behavior: HitTestBehavior.opaque,
                onPointerSignal: _forwardWheelToScrollable,
                child: const SizedBox.expand(),
              ),
            ),
          ),
          Material(
          color: context.colors.scaffoldBackground.withValues(alpha: 0.38),
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: IconButton(
              iconSize: 56,
              color: context.colors.textPrimary,
              onPressed: () => controller.playVideo(),
              icon: const Icon(Icons.play_arrow),
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    if (_videoId == null) {
      return Center(
        child: Text(
          localization.invalidYouTubeLink,
          style: AppTextStyles.h2,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Container(
      constraints: BoxConstraints(minWidth: 300),
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.border, width: 0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: AspectRatio(
          aspectRatio: 18 / 9,
          child: controller == null
              ? const SizedBox.shrink()
              : _buildVideoSurface(context, controller),
        ),
      ),
    );
  }
}
