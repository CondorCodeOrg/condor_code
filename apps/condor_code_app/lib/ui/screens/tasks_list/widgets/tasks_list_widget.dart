import 'package:condor_code/ui/navigation/route_constants.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/empty_state.dart';
import 'package:condor_code/ui/widgets/list_item.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

class TasksListWidget extends StatelessWidget {
  const TasksListWidget({
    required this.lessonName,
    required this.tasks,
    required this.isLoading,
    required this.isEmpty,
    super.key,
  });

  final String lessonName;
  final List<TaskItem> tasks;
  final bool isLoading, isEmpty;

  @override
  Widget build(BuildContext context) {
    late final Widget content;
    if (isEmpty) {
      content = EmptyStateWidget(
        imgUrl: 'packages/ui_kit/assets/images/empty_courses.svg',
        title: localization.noTasksInformation,
        description: localization.informationWhereTasksLocated(lessonName),
      );
    } else {
      content = ListView.separated(
        shrinkWrap: true,
        itemCount: tasks.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 14);
        },
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListItem(
            name: task.name,
            imageUrl: task.imageUrl,
            id: task.id,
            navigation: () => context.push(RouteConstants.taskDetails),
          );
        },
      );
    }

    return Skeleton(
      name: CondorHollowSkeletonIds.tasksList,
      loading: isLoading,
      color: AppColors.grey600.withValues(alpha: 0.42),
      highlightColor: AppColors.neon.withValues(alpha: 0.14),
      child: content,
    );
  }
}
