import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/youtube_player.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:ui_kit/widgets/markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseLessonDetailsPanel extends StatelessWidget {
  const CourseLessonDetailsPanel({
    super.key,
    required this.lesson,
    required this.isLoading,
    this.shrinkWrap = false,
  });

  final Lesson? lesson;
  final bool isLoading;

  /// When true, the panel sizes to its content instead of expanding.
  /// Use inside a scrollable parent (e.g. narrow layout).
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey600.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey400.withValues(alpha: 0.55)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: (isLoading || lesson == null)
            ? (width < 700)
                  ? Skeleton(
                      name:
                          CondorHollowSkeletonIds.lessonDetailPanelMiddleScreen,
                      loading: true,
                      color: AppColors.grey600.withValues(alpha: 0.42),
                      highlightColor: AppColors.neon.withValues(alpha: 0.12),
                      child: const SizedBox.shrink(),
                    )
                  : Skeleton(
                      name: CondorHollowSkeletonIds
                          .lessonTasksDetailPanelFullScreen,
                      loading: true,
                      color: AppColors.grey600.withValues(alpha: 0.42),
                      highlightColor: AppColors.neon.withValues(alpha: 0.12),
                      child: const SizedBox.shrink(),
                    )
            : _LessonContent(lesson: lesson!, shrinkWrap: shrinkWrap),
      ),
    );
  }
}

class _LessonContent extends StatelessWidget {
  const _LessonContent({required this.lesson, required this.shrinkWrap});

  final Lesson lesson;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final body = Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          YouTubePlayerWidget(
            key: ValueKey('${lesson.id}|${lesson.youtubeUrl}'),
            youtubeUrl: lesson.youtubeUrl,
          ),
          if (lesson.isYouTubeLesson) _WatchOnYouTubeLink(lesson: lesson),
          const SizedBox(height: 20),
          Markdown(data: lesson.description),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
      children: [
        _LessonHeader(lesson: lesson),
        const Divider(color: AppColors.grey600, height: 1),
        if (shrinkWrap)
          body
        else
          Expanded(child: SingleChildScrollView(child: body)),
      ],
    );
  }
}

class _LessonHeader extends StatelessWidget {
  const _LessonHeader({required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              lesson.title,
              style: AppTextStyles.body1.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (lesson.topic.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.neon.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                lesson.topic,
                style: AppTextStyles.caption2.copyWith(
                  color: AppColors.neon,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _WatchOnYouTubeLink extends StatelessWidget {
  const _WatchOnYouTubeLink({required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          onPressed: () async {
            final url = Uri.parse(lesson.youtubeUrl);
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
          icon: const Icon(Icons.open_in_new, size: 16, color: AppColors.neon),
          label: Text(
            localization.watchOnYouTube,
            style: AppTextStyles.body2.copyWith(color: AppColors.neon),
          ),
        ),
      ),
    );
  }
}
