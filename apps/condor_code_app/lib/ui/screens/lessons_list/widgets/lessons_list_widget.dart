import 'package:condor_code/ui/navigation/route_constants.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/empty_state.dart';
import 'package:condor_code/ui/widgets/list_item.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

class LessonsListWidget extends StatelessWidget {
  const LessonsListWidget({
    required this.lessonName,
    required this.lessons,
    required this.isLoading,
    required this.isEmpty,
    super.key,
  });

  final String lessonName;
  final List<LessonItem> lessons;
  final bool isLoading, isEmpty;

  @override
  Widget build(BuildContext context) {
    late final Widget content;
    if (isEmpty) {
      content = EmptyStateWidget(
        imgUrl: 'assets/images/empty_courses.svg',
        title: localization.noLessonsInformation,
        description: localization.informationWhereLessonsLocated(lessonName),
      );
    } else {
      content = ListView.separated(
        shrinkWrap: true,
        itemCount: lessons.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 14);
        },
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return ListItem(
            name: lesson.name,
            imageUrl: lesson.imageUrl,
            bottomText: lesson.topic,
            id: lesson.id,
            navigation: () => context.push(RouteConstants.lessonDetails),
          );
        },
      );
    }

    return Skeleton(
      name: CondorHollowSkeletonIds.lessonsListFullScreen,
      loading: isLoading,
      color: context.colors.surface.withValues(alpha: 0.42),
      highlightColor: context.colors.accent.withValues(alpha: 0.14),
      child: content,
    );
  }
}
