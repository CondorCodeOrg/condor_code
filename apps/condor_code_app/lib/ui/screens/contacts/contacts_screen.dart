import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/screens/contacts/contacts_cubit/contacts_cubit.dart';
import 'package:condor_code/ui/screens/contacts/contacts_cubit/contacts_state.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/top_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:ui_kit/widgets/condor_code_network_image_view.dart';
import 'package:url_launcher/url_launcher.dart';

/// Replace with your own URLs.
const String _urlYouTube = 'https://www.youtube.com/@Oleh_Savenko';
const String _urlTelegramChannel =
    'https://t.me/oleh_savenko_mobile_development';
const String _urlTelegramGroup = 'https://t.me/flutter_coding_ua';
const String _urlLinkedIn =
    'https://www.linkedin.com/in/oleh-savenko-7051061ba/';
const String _urlTikTok =
    'https://www.tiktok.com/@oleh_savenko_mobile?_r=1&_t=ZS-94Fn7YEpn08';

/// Short video preview for a block. Add your own: videoUrl + thumbnail (asset or url).
class ContactVideoPreview {
  const ContactVideoPreview({
    required this.videoUrl,
    this.thumbnailAsset,
    this.thumbnailUrl,
    this.title,
  });

  final String videoUrl;
  final String? thumbnailAsset;
  final String? thumbnailUrl;
  final String? title;
}

/// Block with description and one horizontal video on the right (YouTube, Telegram channel, Telegram group).
class ContactBlockWithVideos {
  const ContactBlockWithVideos({
    required this.title,
    required this.description,
    required this.url,
    required this.icon,
    this.mainVideo,
  });

  final String title;
  final String description;
  final String url;
  final IconData icon;

  /// Main video for the block — displayed horizontally on the right. Add your own: videoUrl + thumbnail.
  final ContactVideoPreview? mainVideo;
}

/// Compact contact without video (LinkedIn, TikTok).
class _ContactEntry {
  const _ContactEntry({
    required this.title,
    required this.description,
    required this.url,
    required this.icon,
  });

  final String title;
  final String description;
  final String url;
  final IconData icon;
}

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  static List<ContactBlockWithVideos> _blocksWithVideos() {
    return [
      ContactBlockWithVideos(
        title: localization.youTube,
        description: localization.youtubeBlockDesc,
        url: _urlYouTube,
        icon: Icons.play_circle_filled_rounded,
        mainVideo: const ContactVideoPreview(
          videoUrl: _urlYouTube,
          thumbnailAsset: 'assets/images/oleh_youtube_contacts.png',
        ),
        // Add your own: mainVideo: ContactVideoPreview(videoUrl: 'https://youtube.com/watch?v=xxx', thumbnailUrl: 'https://img.youtube.com/vi/xxx/maxresdefault.jpg'),
      ),
    ];
  }

  static List<_ContactEntry> _telegramEntries() {
    return [
      _ContactEntry(
        title: '${localization.telegram} ${localization.telegramChannel}',
        description: localization.telegramChannelDesc,
        url: _urlTelegramChannel,
        icon: Icons.telegram,
      ),
      _ContactEntry(
        title: '${localization.telegram} ${localization.telegramGroup}',
        description: localization.telegramGroupDesc,
        url: _urlTelegramGroup,
        icon: Icons.groups_rounded,
      ),
    ];
  }

  static List<_ContactEntry> _socialEntries() {
    return [
      _ContactEntry(
        title: localization.linkedIn,
        description: localization.mentorName,
        url: _urlLinkedIn,
        icon: Icons.business_center_rounded,
      ),
      _ContactEntry(
        title: localization.tiktok,
        description: localization.mentorName,
        url: _urlTikTok,
        icon: Icons.music_video_rounded,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 1024;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: !isDesktop
          ? TopNavigationBar(
              text: localization.contactsScreen,
              isLeading: false,
            )
          : null,
      body: Stack(
        children: [
          const Positioned.fill(child: _ContactsBackground()),
          SafeArea(
            child: BlocProvider(
              create: (context) => di<ContactsCubit>(),
              child: BlocBuilder<ContactsCubit, ContactsState>(
                builder: (context, state) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1100),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 32,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    localization.subscribeToUs,
                                    style: AppTextStyles.body1.copyWith(
                                      color: context.colors.textPrimary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 32),
                                  ..._blocksWithVideos().map(
                                    (b) => Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 32,
                                      ),
                                      child: _ContactRowBlock(block: b),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  _buildCompactRow(context),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactRow(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isNarrow = width < 500;

    Widget buildRow(List<_ContactEntry> entries) {
      if (isNarrow) {
        return Column(
          children: entries
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _ContactCard(entry: e),
                ),
              )
              .toList(),
        );
      }
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: entries
            .map(
              (e) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _ContactCard(entry: e),
                ),
              ),
            )
            .toList(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildRow(_telegramEntries()),
        const SizedBox(height: 16),
        buildRow(_socialEntries()),
      ],
    );
  }
}

class _ContactRowBlock extends StatefulWidget {
  const _ContactRowBlock({required this.block});

  final ContactBlockWithVideos block;

  @override
  State<_ContactRowBlock> createState() => _ContactRowBlockState();
}

class _ContactRowBlockState extends State<_ContactRowBlock> {
  bool _hover = false;

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final b = widget.block;
    final isWide = MediaQuery.sizeOf(context).width >= 700;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: context.colors.scaffoldBackground.withValues(alpha: _hover ? 0.98 : 0.88),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hover
                ? context.colors.accent.withValues(alpha: 0.45)
                : context.colors.border.withValues(alpha: 0.35),
            width: _hover ? 1.2 : 0.8,
          ),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: context.colors.accent.withValues(alpha: 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: isWide ? _buildWideLayout(b) : _buildNarrowLayout(b),
      ),
    );
  }

  Widget _buildWideLayout(ContactBlockWithVideos b) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIcon(b.icon),
              SizedBox(height: 20),
              Text(
                b.title,
                style: AppTextStyles.h2.copyWith(
                  color: context.colors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Text(
                b.description,
                style: AppTextStyles.body3.copyWith(
                  color: context.colors.textPrimary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              _buildLink(b),
            ],
          ),
        ),
        const SizedBox(width: 28),
        Expanded(flex: 2, child: _buildHorizontalVideoArea(b)),
      ],
    );
  }

  Widget _buildNarrowLayout(ContactBlockWithVideos b) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIcon(b.icon),
        SizedBox(height: 14),
        Text(
          b.title,
          style: AppTextStyles.h2.copyWith(
            color: context.colors.accent,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Text(
          b.description,
          style: AppTextStyles.body3.copyWith(
            color: context.colors.textPrimary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        _buildLink(b),
        const SizedBox(height: 20),
        _buildHorizontalVideoArea(b),
      ],
    );
  }

  Widget _buildHorizontalVideoArea(ContactBlockWithVideos b) {
    final video = b.mainVideo;
    if (video == null) {
      return _HorizontalVideoPlaceholder(onTap: () => _openUrl(b.url));
    }
    return _HorizontalVideoCard(video: video, fallbackUrl: b.url);
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      height: 52,
      width: 52,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: context.colors.accent, size: 28),
    );
  }

  Widget _buildLink(ContactBlockWithVideos b) {
    return InkWell(
      onTap: () => _openUrl(b.url),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localization.goTo,
              style: AppTextStyles.button.copyWith(
                color: context.colors.accent,
                fontSize: 14,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_rounded,
              size: 20,
              color: context.colors.accent,
            ),
          ],
        ),
      ),
    );
  }
}

/// Horizontal video on the right side of the block (16:9). Add mainVideo with thumbnailUrl/thumbnailAsset.
class _HorizontalVideoCard extends StatefulWidget {
  const _HorizontalVideoCard({required this.video, required this.fallbackUrl});

  final ContactVideoPreview video;
  final String fallbackUrl;

  @override
  State<_HorizontalVideoCard> createState() => _HorizontalVideoCardState();
}

class _HorizontalVideoCardState extends State<_HorizontalVideoCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
    _pulseAnimation = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _openVideo(BuildContext context) async {
    final uri = Uri.parse(widget.video.videoUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = width / (16 / 9);
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _openVideo(context),
            borderRadius: BorderRadius.circular(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: width,
                height: height,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 1 + (0.04 * _pulseAnimation.value),
                          child: child,
                        );
                      },
                      child: _buildThumbnail(),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            context.colors.textPrimary.withValues(alpha: 0.5),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: context.colors.accent.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: context.colors.accent,
                          size: 48,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildThumbnail() {
    if (widget.video.thumbnailAsset != null &&
        widget.video.thumbnailAsset!.isNotEmpty) {
      return Image.asset(widget.video.thumbnailAsset!, fit: BoxFit.cover);
    }
    if (widget.video.thumbnailUrl != null &&
        widget.video.thumbnailUrl!.isNotEmpty) {
      return CCNetworkImageView(
        imageUrl: widget.video.thumbnailUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() {
    return Container(
      color: context.colors.surface,
      child: Icon(
        Icons.videocam_rounded,
        color: context.colors.border,
        size: 56,
      ),
    );
  }
}

/// Placeholder when mainVideo is not set — tap opens the block URL.
class _HorizontalVideoPlaceholder extends StatelessWidget {
  const _HorizontalVideoPlaceholder({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = width / (16 / 9);
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: context.colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: context.colors.border.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.video_library_rounded,
                    color: context.colors.border,
                    size: 48,
                  ),
                  SizedBox(height: 12),
                  Text(
                    localization.addVideoPlaceholder,
                    style: AppTextStyles.caption1.copyWith(
                      color: context.colors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ContactCard extends StatefulWidget {
  const _ContactCard({required this.entry});

  final _ContactEntry entry;

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hover = false;

  Future<void> _openUrl() async {
    final uri = Uri.parse(widget.entry.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.entry;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _openUrl,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 180),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.colors.scaffoldBackground.withValues(alpha: _hover ? 1 : 0.85),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _hover
                    ? context.colors.accent.withValues(alpha: 0.5)
                    : context.colors.border.withValues(alpha: 0.4),
                width: _hover ? 1.2 : 0.8,
              ),
              boxShadow: _hover
                  ? [
                      BoxShadow(
                        color: context.colors.accent.withValues(alpha: 0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(e.icon, color: context.colors.accent, size: 28),
                ),
                SizedBox(height: 14),
                Text(
                  e.title,
                  style: AppTextStyles.body2.copyWith(
                    color: context.colors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  e.description,
                  style: AppTextStyles.body3.copyWith(
                    color: context.colors.textPrimary,
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      localization.goTo,
                      style: AppTextStyles.button.copyWith(
                        color: context.colors.accent,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: context.colors.accent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactsBackground extends StatelessWidget {
  const _ContactsBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _WavyContactsPainter(
        waveColor: context.colors.surface.withValues(alpha: 0.08),
      ),
      size: Size.infinite,
    );
  }
}

class _WavyContactsPainter extends CustomPainter {
  const _WavyContactsPainter({required this.waveColor});

  final Color waveColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = waveColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const step = 90.0;
    for (var y = 0.0; y < size.height + 120; y += step) {
      final path = Path();
      path.moveTo(0, y);
      for (var x = 0.0; x < size.width + 200; x += 50) {
        path.quadraticBezierTo(x + 25, y + 6, x + 50, y);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
