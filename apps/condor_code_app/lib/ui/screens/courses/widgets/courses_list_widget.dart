import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/empty_state.dart';
import 'package:condor_code/ui/widgets/list_item.dart';
import 'package:condor_code/ui/widgets/web_grid_item.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class CoursesListWidget extends StatelessWidget {
  const CoursesListWidget({
    required this.courses,
    required this.isLoading,
    required this.isEmpty,
    required this.onCourseSelected,
    super.key,
  });

  final List<Course> courses;
  final bool isLoading;
  final bool isEmpty;
  final void Function(Course course) onCourseSelected;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    if (isEmpty && !isLoading) {
      return EmptyStateWidget(
        imgUrl: 'packages/ui_kit/assets/images/condor_app_icon.png',
        title: localization.noCoursesInformation,
        description: localization.emptyCoursesList,
      );
    }
    if (isMobile) {
      return Skeleton(
        name: CondorHollowSkeletonIds.coursesListMobile,
        loading: isLoading,
        color: context.colors.surface.withValues(alpha: 0.42),
        highlightColor: context.colors.accent.withValues(alpha: 0.14),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: courses.length,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final course = courses[index];

            return ListItem(
              name: course.name,
              imageUrl: course.imageUrl,
              bottomText: localization.lessonsAmount(course.lessonsAmount),
              id: course.id,
              navigation: () => onCourseSelected(course),
            );
          },
        ),
      );
    }
    return GridView.builder(
      itemCount: isLoading ? 4 : courses.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        if (isLoading) {
          return WebGridItem(
            onTap: () {},
            imageUrl: '',
            name: '',
            description: '',
            isLoading: true,
          );
        }

        final course = courses[index];

        return WebGridItem(
          onTap: () => onCourseSelected(course),
          imageUrl: course.imageUrl,
          name: course.name,
          description: localization.lessonsAmount(course.lessonsAmount),
          isLoading: false,
        );
      },
    );
  }
}
