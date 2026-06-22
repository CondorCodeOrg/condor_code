import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/analytics_constants.dart';
import 'package:condor_code/ui/base/provider/events/snack_bar_events_provider.dart';
import 'package:condor_code/ui/navigation/route_constants.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/side_panel_screen_widget.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

class CourseActionPanel extends StatelessWidget {
  const CourseActionPanel({
    super.key,
    required this.lessonId,
    required this.isTasksExist,
    required this.courseId,
    required this.courseName,
    this.lesson,
    this.expanded = false,
  });

  final String? lessonId;
  final bool isTasksExist;
  final String courseId;
  final String courseName;

  /// Full lesson object, required to navigate to the Summary screen.
  final Lesson? lesson;

  /// When true, renders a tall card with header + button (wide layout column).
  /// When false, renders just the button (medium/narrow bottom bar).
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final onPressed = isTasksExist && lessonId != null
        ? () => _openKnowledgeCheckForLesson(
            context,
            courseId: courseId,
            lessonId: lessonId!,
            courseName: courseName,
          )
        : null;

    final onSummaryPressed =
        lesson != null ? () => _openSummary(context, lesson!) : null;

    if (!expanded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CheckKnowledgeButton(onPressed: onPressed),
          const SizedBox(height: 8),
          _SummaryButton(onPressed: onSummaryPressed),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey600.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey400.withValues(alpha: 0.55)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SidePanelHeader(
              icon: Icons.bolt_rounded,
              title: localization.courseActions,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _CheckKnowledgeButton(onPressed: onPressed),
                  const SizedBox(height: 8),
                  _SummaryButton(onPressed: onSummaryPressed),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _openSummary(BuildContext context, Lesson lesson) {
    di<Analytics>().logEvent(AnalyticsEventName.buttonClick, {
      AnalyticsPropertyName.buttonId: AnalyticsButtonId.summary,
      AnalyticsPropertyName.lessonId: lesson.id,
    });
    context.push(RouteConstants.lessonSummary, extra: lesson);
  }

  Future<void> _openKnowledgeCheckForLesson(
    BuildContext context, {
    required String courseId,
    required String lessonId,
    required String courseName,
  }) async {
    final result = await di<TasksRepository>().getTasks(lessonId);
    if (!context.mounted) return;

    result.fold(
      onSuccess: (tasks) {
        if (!context.mounted) return;
        if (tasks.isEmpty) {
          di<SnackBarEventsProvider>().addEvent(
            SnackBarEvent.info(localization.noTasksInformation),
          );
          return;
        }
        context.push(
          '${RouteConstants.knowledgeCheck}/$courseId/lessons/$lessonId/tasks/${tasks.first.id}',
          extra: courseName,
        );
      },
      onError: (error) {
        if (!context.mounted) return;
        di<SnackBarEventsProvider>().addEvent(
          SnackBarEvent.error(error.message),
        );
      },
    );
  }
}

class _CheckKnowledgeButton extends StatelessWidget {
  const _CheckKnowledgeButton({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.neon,
          foregroundColor: AppColors.darkGrey800,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.quiz_outlined, size: 20),
        label: Text(
          localization.checkMyKnowledge,
          style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _SummaryButton extends StatelessWidget {
  const _SummaryButton({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.neon,
          side: BorderSide(color: AppColors.neon),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.menu_book_outlined, size: 20),
        label: Text(
          localization.summary,
          style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
