import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/navigation/route_constants.dart';
import 'package:condor_code/ui/l10n/app_localizations.dart';
import 'package:condor_code/ui/screens/knowledge_base/knowledge_base_cubit/knowledge_base_home_cubit.dart';
import 'package:condor_code/ui/screens/knowledge_base/knowledge_base_cubit/knowledge_base_home_state.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

/// Knowledge base dashboard: hero, featured roadmap card, categories, pillars, latest updates.
class KnowledgeBaseHomeScreen extends StatelessWidget {
  const KnowledgeBaseHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<KnowledgeBaseHomeCubit>(),
      child: const _KnowledgeBaseHomeBody(),
    );
  }
}

class _KnowledgeBaseHomeBody extends StatelessWidget {
  const _KnowledgeBaseHomeBody();

  static double _wideUpdatesWidth = 300;
  static double _wideBreakpoint = 960;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ColoredBox(
      color: context.colors.scaffoldBackground,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= _wideBreakpoint;
          final pad = wide ? 28.0 : 16.0;

          final mainColumn = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroBlock(l10n: l10n),
              const SizedBox(height: 28),
              _InteractiveRoadmapCard(l10n: l10n),
              const SizedBox(height: 20),
              _CategoryPairRow(l10n: l10n),
              const SizedBox(height: 36),
              _LearningPillarsBlock(l10n: l10n),
            ],
          );

          final updates = _LatestUpdatesPanel(l10n: l10n);

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(pad, 24, pad, 40),
            child: wide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: mainColumn),
                      const SizedBox(width: 24),
                      SizedBox(width: _wideUpdatesWidth, child: updates),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [mainColumn, const SizedBox(height: 28), updates],
                  ),
          );
        },
      ),
    );
  }
}

class _HeroBlock extends StatelessWidget {
  const _HeroBlock({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyles.h1.copyWith(
              color: context.colors.textPrimary,
              fontSize: 32,
              height: 1.2,
              fontWeight: FontWeight.w800,
            ),
            children: [
              TextSpan(text: l10n.knowledgeBaseHeroTitlePrefix),
              TextSpan(
                text: l10n.knowledgeBaseHeroTitleHighlight,
                style: TextStyle(color: context.colors.accent),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),
        Text(
          l10n.knowledgeBaseHeroSubtitle,
          style: AppTextStyles.body1.copyWith(
            color: context.colors.textSecondary,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}

class _InteractiveRoadmapCard extends StatelessWidget {
  const _InteractiveRoadmapCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.go(RouteConstants.knowledgeBaseRoadmap),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: context.colors.surface.withValues(alpha: 0.65),
            border: Border.all(color: context.colors.accent.withValues(alpha: 0.35)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _CircuitGridPainter(
                      gridColor: context.colors.accent.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _TagPill(
                            text: l10n.knowledgeBaseTagPopular,
                            foreground: context.colors.textPrimary,
                            background: context.colors.accent,
                          ),
                          _TagPill(
                            text: l10n.knowledgeBaseTagInteractive,
                            foreground: context.colors.textPrimary,
                            background: context.colors.border,
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Text(
                        l10n.knowledgeBaseRoadmapCardTitle,
                        style: AppTextStyles.h2.copyWith(
                          color: context.colors.textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        l10n.knowledgeBaseRoadmapCardDesc,
                        style: AppTextStyles.body2.copyWith(
                          color: context.colors.textSecondary,
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 18),
                      Row(
                        children: [
                          Text(
                            '${l10n.knowledgeBaseStartLearning} →',
                            style: AppTextStyles.body2.copyWith(
                              color: context.colors.accent,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TagPill extends StatelessWidget {
  const _TagPill({
    required this.text,
    required this.foreground,
    required this.background,
  });

  final String text;
  final Color foreground;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: AppTextStyles.caption2.copyWith(
          color: foreground,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _CircuitGridPainter extends CustomPainter {
  const _CircuitGridPainter({required this.gridColor});

  final Color gridColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    const step = 22.0;
    for (var x = 0.0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CategoryPairRow extends StatelessWidget {
  const _CategoryPairRow({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 520;
        const gap = 16.0;
        final flutterCard = _SmallCategoryCard(
          icon: Icons.grid_view_rounded,
          title: l10n.knowledgeBaseFlutterBasics,
          subtitle: l10n.knowledgeBaseLessonCount(42),
          onTap: () => context.go(RouteConstants.knowledgeBaseResources),
        );
        final dartCard = _SmallCategoryCard(
          icon: Icons.memory_rounded,
          title: l10n.knowledgeBaseDartDeepDive,
          subtitle: l10n.knowledgeBaseModuleCount(18),
          onTap: () => context.go(RouteConstants.knowledgeBaseResources),
        );
        if (narrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              flutterCard,
              const SizedBox(height: gap),
              dartCard,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: flutterCard),
            const SizedBox(width: gap),
            Expanded(child: dartCard),
          ],
        );
      },
    );
  }
}

class _SmallCategoryCard extends StatelessWidget {
  const _SmallCategoryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surface.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.colors.accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: context.colors.accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.body2.copyWith(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppTextStyles.caption1.copyWith(
                        color: context.colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: context.colors.accent),
            ],
          ),
        ),
      ),
    );
  }
}

class _LearningPillarsBlock extends StatelessWidget {
  const _LearningPillarsBlock({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.knowledgeBaseLearningPillars,
          style: AppTextStyles.h2.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final cols = w >= 900
                ? 4
                : w >= 600
                ? 2
                : 1;
            final pillars = [
              (
                context.colors.accent,
                l10n.knowledgeBasePillarBasicsTitle,
                l10n.knowledgeBasePillarBasicsItems,
              ),
              (
                const Color(0xFFE8D44D),
                l10n.knowledgeBasePillarAdvancedTitle,
                l10n.knowledgeBasePillarAdvancedItems,
              ),
              (
                Color(0xFFFF9F43),
                l10n.knowledgeBasePillarArchTitle,
                l10n.knowledgeBasePillarArchItems,
              ),
              (
                context.colors.alert,
                l10n.knowledgeBasePillarProdTitle,
                l10n.knowledgeBasePillarProdItems,
              ),
            ];
            return Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                for (final p in pillars)
                  SizedBox(
                    width: cols == 1
                        ? w
                        : cols == 2
                        ? (w - 14) / 2
                        : (w - 14 * 3) / 4,
                    child: _PillarCard(
                      accent: p.$1,
                      title: p.$2,
                      bodyLines: p.$3.split('\n'),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _PillarCard extends StatelessWidget {
  const _PillarCard({
    required this.accent,
    required this.title,
    required this.bodyLines,
  });

  final Color accent;
  final String title;
  final List<String> bodyLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.border.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(11),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(14, 14, 14, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.caption1.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 12),
                for (final line in bodyLines) ...[
                  Text(
                    '· $line',
                    style: AppTextStyles.caption2.copyWith(
                      color: context.colors.textSecondary,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LatestUpdatesPanel extends StatelessWidget {
  const _LatestUpdatesPanel({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.colors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.colors.border.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.history_rounded,
                color: context.colors.accent,
                size: 22,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.knowledgeBaseLatestUpdates,
                  style: AppTextStyles.body2.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<KnowledgeBaseHomeCubit, KnowledgeBaseHomeState>(
            builder: (context, state) {
              if (state.isLoading && state.news.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Skeleton(
                    name: CondorHollowSkeletonIds.knowledgeBaseNews,
                    loading: true,
                    color: context.colors.surface.withValues(alpha: 0.4),
                    highlightColor: context.colors.accent.withValues(alpha: 0.12),
                    child: const SizedBox.shrink(),
                  ),
                );
              }
              return Column(
                children: [
                  for (var i = 0; i < state.news.length; i++) ...[
                    if (i > 0) const SizedBox(height: 14),
                    _NewsTile(item: state.news[i], l10n: l10n),
                  ],
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: context.colors.accent,
                    side: BorderSide(color: context.colors.accent),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(l10n.knowledgeBaseViewAllActivity),
                ),
              ),
              const SizedBox(width: 14),
              SizedBox(
                width: 48,
                height: 48,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox.expand(
                      child: CircularProgressIndicator(
                        value: 0.74,
                        strokeWidth: 4,
                        backgroundColor: context.colors.border,
                        color: context.colors.accent,
                      ),
                    ),
                    Text(
                      '74%',
                      style: AppTextStyles.caption2.copyWith(
                        color: context.colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.chevron_left, color: context.colors.textSecondary),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.chevron_right, color: context.colors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NewsTile extends StatelessWidget {
  const _NewsTile({required this.item, required this.l10n});

  final KnowledgeBaseNewsItem item;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (item.category) {
      KnowledgeBaseNewsCategory.article => (
        l10n.knowledgeBaseNewsCategoryArticle,
        context.colors.accent,
      ),
      KnowledgeBaseNewsCategory.roadmap => (
        l10n.knowledgeBaseNewsCategoryRoadmap,
        Color(0xFFE8D44D),
      ),
      KnowledgeBaseNewsCategory.announcement => (
        l10n.knowledgeBaseNewsCategoryAnnouncement,
        context.colors.alert,
      ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                border: Border.all(color: color.withValues(alpha: 0.85)),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                label,
                style: AppTextStyles.caption2.copyWith(
                  color: color,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              item.relativeTimeLabel,
              style: AppTextStyles.caption2.copyWith(color: context.colors.textSecondary),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          item.title,
          style: AppTextStyles.body2.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4),
        Text(
          item.snippet,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.caption1.copyWith(
            color: context.colors.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
