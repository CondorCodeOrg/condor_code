import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/screens/task_answer/task_answer_cubit/task_answer_cubit.dart';
import 'package:condor_code/ui/screens/task_answer/task_answer_cubit/task_answer_state.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:condor_code/ui/widgets/homework_images_gallery.dart';
import 'package:condor_code/ui/widgets/homework_tasks_skeleton.dart';
import 'package:condor_code/ui/widgets/media_widget.dart';
import 'package:condor_code/ui/widgets/top_navigation_bar.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/widgets/markdown.dart';

class TaskAnswerScreen extends StatelessWidget {
  final Answer answer;

  const TaskAnswerScreen({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<TaskAnswerCubit>(param1: answer),
      child: BlocBuilder<TaskAnswerCubit, TaskAnswerState>(
        builder: (context, state) {
          if (state is TaskAnswerLoaded) {
            return Scaffold(
              backgroundColor: context.colors.scaffoldBackground,
              appBar: TopNavigationBar(
                text: state.answer.title,
                topPadding: 20,
              ),
              body: SafeArea(child: _MainContent(answer: state.answer)),
            );
          }
          return Scaffold(
            backgroundColor: context.colors.scaffoldBackground,
            body: SafeArea(child: HomeworkTasksSkeleton()),
          );
        },
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  final Answer answer;

  const _MainContent({required this.answer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, right: 20, left: 20, top: 16),
      child: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 1,
            child: MediaWidget(url: answer.mediaUrl),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: HomeworkImagesGallery(listImages: answer.listImages),
          ),
          Markdown(data: answer.description),
        ],
      ),
    );
  }
}
