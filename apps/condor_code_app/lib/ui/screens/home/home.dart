import 'dart:math' as math;

import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/analytics_constants.dart';
import 'package:condor_code/ui/navigation/route_constants.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:url_launcher/url_launcher.dart';

/// Condor Code web home page: welcome, platform description, features, and YouTube link.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  static const String _youtubeChannelUrl =
      'https://www.youtube.com/@Oleh_Savenko';
  static const String _youtubePhotoAsset =
      'assets/images/oleh_youtube_photo.png';

  late AnimationController _animController;
  late AnimationController _floatController;
  late Animation<double> _animHeadline;
  late Animation<double> _animIntro;
  late Animation<double> _animFeatures;
  late Animation<double> _animHero;
  late Animation<double> _animCta;
  late Animation<double> _animFooter;
  bool _isLearnHovered = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    const curve = Curves.easeOutCubic;
    _animHeadline = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.08, 0.28, curve: curve),
    );
    _animIntro = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.18, 0.38, curve: curve),
    );
    _animFeatures = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.30, 0.55, curve: curve),
    );
    _animHero = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.45, 0.70, curve: curve),
    );
    _animCta = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.60, 0.82, curve: curve),
    );
    _animFooter = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.75, 1.0, curve: curve),
    );
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);
    _animController.forward();
  }

  @override
  void dispose() {
    _floatController.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _openYouTube() async {
    final uri = Uri.parse(_youtubeChannelUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          _buildBackground(context),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeadline(),
                          const SizedBox(height: 20),
                          _buildIntro(),
                          const SizedBox(height: 40),
                          _buildFeatures(),
                          const SizedBox(height: 24),
                          _buildStartLearningButton(),
                          const SizedBox(height: 16),
                          // TODO: Uncomment when knowlage base will be ready
                          // TextButton(
                          //   onPressed: () =>
                          //       context.go(RouteConstants.knowledgeBase),
                          //   child: Text(
                          //     localization.knowledgeBaseOpen,
                          //     style: AppTextStyles.body2.copyWith(
                          //       color: context.colors.accent,
                          //       fontWeight: FontWeight.w600,
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 48),
                          _buildHeroPlaceholder(),
                          const SizedBox(height: 48),
                          _buildYouTubeCta(),
                          const SizedBox(height: 56),
                          _buildFooter(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: _WavyBackgroundPainter(
          waveColor: context.colors.surface.withValues(alpha: 0.12),
        ),
        size: Size.infinite,
      ),
    );
  }

  Widget _buildHeadline() {
    return AnimatedBuilder(
      animation: _animHeadline,
      builder: (context, child) {
        final width = MediaQuery.of(context).size.width;
        final isMobile = width < 700;

        return Opacity(
          opacity: _animHeadline.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _animHeadline.value)),
            child: Padding(
              padding: EdgeInsets.only(top: isMobile ? 16 : 0),
              child: RichText(
                text: TextSpan(
                  style: AppTextStyles.h1.copyWith(
                    color: context.colors.textPrimary,
                    fontSize: 32,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    TextSpan(text: localization.welcomeTo),
                    TextSpan(
                      text: localization.condorCodeBrand,
                      style: TextStyle(color: context.colors.accent),
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

  Widget _buildIntro() {
    return AnimatedBuilder(
      animation: _animIntro,
      builder: (context, child) {
        return Opacity(
          opacity: _animIntro.value,
          child: Transform.translate(
            offset: Offset(0, 16 * (1 - _animIntro.value)),
            child: Text(
              localization.homeIntro,
              style: AppTextStyles.body1.copyWith(
                color: context.colors.textPrimary,
                height: 1.6,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatures() {
    final features = [
      (
        lessonName: localization.featureLessonsTitle,
        description: localization.featureLessonsDesc,
      ),
      (
        lessonName: localization.featureHomeworkTitle,
        description: localization.featureHomeworkDesc,
      ),
      (
        lessonName: localization.featureCheckTitle,
        description: localization.featureCheckDesc,
      ),
    ];

    return AnimatedBuilder(
      animation: _animFeatures,
      builder: (context, child) {
        return Opacity(
          opacity: _animFeatures.value,
          child: Transform.translate(
            offset: Offset(0, 24 * (1 - _animFeatures.value)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < features.length; i++) ...[
                  _FeatureCard(
                    title: features[i].lessonName,
                    description: features[i].description,
                  ),
                  if (i < features.length - 1) const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeroPlaceholder() {
    return AnimatedBuilder(
      animation: _animHero,
      builder: (context, child) {
        return Opacity(
          opacity: _animHero.value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - _animHero.value)),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    maxWidth: 720,
                    minHeight: 320,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        context.colors.surface,
                        context.colors.border.withValues(alpha: 0.6),
                      ],
                    ),
                    border: Border.all(
                      color: context.colors.border.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _floatController,
                        builder: (context, child) {
                          final t = _floatController.value;
                          final dy = math.sin(t * math.pi) * -8;
                          final scale = 1 + (0.02 * t);
                          return Transform.translate(
                            offset: Offset(0, dy),
                            child: Transform.scale(scale: scale, child: child),
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 220,
                              height: 220,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: context.colors.accent.withValues(
                                      alpha: 0.22,
                                    ),
                                    blurRadius: 50,
                                    spreadRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(140),
                              child: Image.asset(
                                _youtubePhotoAsset,
                                width: 240,
                                height: 240,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStartLearningButton() {
    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        final pulse = 0.65 + (_floatController.value * 0.35);
        return Center(
          child: MouseRegion(
            onEnter: (_) => setState(() => _isLearnHovered = true),
            onExit: (_) => setState(() => _isLearnHovered = false),
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                di<Analytics>().logEvent(AnalyticsEventName.buttonClick, {
                  AnalyticsPropertyName.buttonId:
                      AnalyticsButtonId.homeLearnMore,
                  AnalyticsPropertyName.destination: RouteConstants.courses,
                });
                context.go(RouteConstants.courses);
              },
              child: AnimatedScale(
                duration: Duration(milliseconds: 180),
                scale: _isLearnHovered ? 1.03 : 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: context.colors.accent.withValues(alpha: 0.20 * pulse),
                        blurRadius: 28,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 34,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          context.colors.accent.withValues(
                            alpha: _isLearnHovered ? 0.95 : 0.88,
                          ),
                          context.colors.accent.withValues(
                            alpha: _isLearnHovered ? 0.95 : 0.86,
                          ),
                        ],
                      ),
                    ),
                    child: Text(
                      localization.startLearning,
                      style: AppTextStyles.button.copyWith(
                        color: context.colors.textPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildYouTubeCta() {
    return AnimatedBuilder(
      animation: _animCta,
      builder: (context, child) {
        return Opacity(
          opacity: _animCta.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _animCta.value)),
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.surface.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: context.colors.accent.withValues(alpha: 0.35),
                        width: 0.9,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: context.colors.accent.withValues(alpha: 0.08),
                          blurRadius: 22,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: context.colors.accent.withValues(alpha: 0.22),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.campaign_rounded,
                            color: context.colors.accent,
                            size: 18,
                          ),
                        ),
                        SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            localization.youtubeCtaText,
                            style: AppTextStyles.body2.copyWith(
                              color: context.colors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.45,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _openYouTube,
                    style: AppButtonStyles.mainButtonStyle(context).copyWith(
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 16,
                        ),
                      ),
                    ),
                    icon: Icon(
                      Icons.play_circle_filled,
                      color: context.colors.textPrimary,
                      size: 24,
                    ),
                    label: Text(localization.goToYouTubeChannel),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooter() {
    return AnimatedBuilder(
      animation: _animFooter,
      builder: (context, child) {
        return Opacity(
          opacity: _animFooter.value,
          child: Padding(
            padding: EdgeInsets.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 1,
                  color: context.colors.border.withValues(alpha: 0.5),
                ),
                SizedBox(height: 20),
                Text(
                  localization.footerDescription,
                  style: AppTextStyles.caption1.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  localization.copyright(DateTime.now().year),
                  style: AppTextStyles.caption2.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Card for a single feature with a checkmark.
class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.scaffoldBackground.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colors.border.withValues(alpha: 0.4),
          width: 0.8,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: context.colors.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              color: context.colors.accent,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.body2.copyWith(
                    color: context.colors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  description,
                  style: AppTextStyles.body3.copyWith(
                    color: context.colors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Subtle wavy lines in the background.
class _WavyBackgroundPainter extends CustomPainter {
  const _WavyBackgroundPainter({required this.waveColor});

  final Color waveColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = waveColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const step = 80.0;
    for (var y = 0.0; y < size.height + 100; y += step) {
      final path = Path();
      path.moveTo(0, y);
      for (var x = 0.0; x < size.width + 200; x += 60) {
        path.quadraticBezierTo(x + 30, y + 8, x + 60, y);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
