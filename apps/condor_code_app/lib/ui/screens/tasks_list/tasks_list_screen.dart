import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/screens/tasks_list/tasks_list_cubit/tasks_list_cubit.dart';
import 'package:condor_code/ui/screens/tasks_list/tasks_list_cubit/tasks_list_state.dart';
import 'package:condor_code/ui/screens/tasks_list/widgets/tasks_list_widget.dart';
import 'package:domain/models/lesson.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:condor_code/ui/widgets/top_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksListScreen extends StatelessWidget {
  final Lesson lesson;

  const TasksListScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<TasksListCubit>(param1: lesson.id),
      child: BlocBuilder<TasksListCubit, TasksListState>(
        builder: (BuildContext context, TasksListState state) {
          return Scaffold(
            backgroundColor: context.colors.scaffoldBackground,
            body: SafeArea(
              child: Column(
                children: [
                  TopNavigationBar(text: lesson.title),
                  _MainContent(lessonName: lesson.title, state: state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  final TasksListState state;
  final String lessonName;

  const _MainContent({required this.lessonName, required this.state});

  @override
  Widget build(BuildContext context) {
    final state = this.state;
    return switch (state) {
      TasksListLoading() => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 22, left: 22, bottom: 22),
          child: TasksListWidget(
            tasks: const [],
            isLoading: true,
            isEmpty: false,
            lessonName: lessonName,
          ),
        ),
      ),
      TasksListLoaded() => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 22, left: 22, bottom: 22),
          child: TasksListWidget(
            tasks: state.tasks,
            isLoading: false,
            isEmpty: state.tasks.isEmpty ? true : false,
            lessonName: lessonName,
          ),
        ),
      ),
    };
  }
}
