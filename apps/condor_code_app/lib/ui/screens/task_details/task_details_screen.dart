import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/navigation/route_constants.dart';
import 'package:condor_code/ui/screens/task_details/task_details_cubit/task_details_cubit.dart';
import 'package:condor_code/ui/screens/task_details/task_details_cubit/task_details_state.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/homework_images_gallery.dart';
import 'package:condor_code/ui/widgets/homework_tasks_skeleton.dart';
import 'package:condor_code/ui/widgets/media_widget.dart';
import 'package:condor_code/ui/widgets/top_navigation_bar.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/styles/buttons/app_button_styles.dart';
import 'package:ui_kit/styles/colors/app_colors.dart';
import 'package:ui_kit/widgets/markdown.dart';

class TaskDetailsScreen extends StatelessWidget {
  final String taskId;

  const TaskDetailsScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<TaskDetailsCubit>(param1: taskId),
      child: BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
        builder: (context, state) {
          if (state is TaskDetailsLoaded) {
            return Scaffold(
              backgroundColor: AppColors.grey800,
              appBar: TopNavigationBar(text: state.task.title, topPadding: 20),
              bottomNavigationBar: _CheckButton(task: state.task),
              body: SafeArea(child: _MainContent(task: state.task)),
            );
          }
          return const Scaffold(
            backgroundColor: AppColors.grey800,
            body: SafeArea(child: HomeworkTasksSkeleton(isBottomButton: true)),
          );
        },
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  final Task task;

  const _MainContent({required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, right: 20, left: 20, top: 18),
      child: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 1,
            child: MediaWidget(url: task.mediaUrl),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: HomeworkImagesGallery(listImages: task.listImages),
          ),
          Markdown(data: task.description),
        ],
      ),
    );
  }
}

class _CheckButton extends StatelessWidget {
  final Task task;

  const _CheckButton({required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            context.push(RouteConstants.taskAnswerScreen, extra: task.answer);
          },
          style: AppButtonStyles.mainButtonStyle,
          child: Text(localization.checkMyCode),
        ),
      ),
    );
  }
}
