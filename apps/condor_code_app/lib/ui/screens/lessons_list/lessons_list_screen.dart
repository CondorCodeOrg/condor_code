import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/screens/lessons_list/lessons_list_cubit/lessons_list_cubit.dart';
import 'package:condor_code/ui/screens/lessons_list/lessons_list_cubit/lessons_list_state.dart';
import 'package:condor_code/ui/screens/lessons_list/widgets/lessons_list_widget.dart';
import 'package:domain/models/course.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/top_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonsListScreen extends StatelessWidget {
  final Course course;

  const LessonsListScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1024;
    return BlocProvider(
      create: (context) => di<LessonsListCubit>(param1: course.id),
      child: BlocBuilder<LessonsListCubit, LessonsListState>(
        builder: (BuildContext context, LessonsListState state) {
          return Scaffold(
            appBar: TopNavigationBar(
              topPadding: 20,
              text: localization.lessonsName(course.name),
            ),
            backgroundColor: context.colors.scaffoldBackground,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: isDesktop ? 36 : 24),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isDesktop
                          ? MediaQuery.of(context).size.width * 0.88
                          : double.infinity,
                    ),
                    child: _MainContent(lessonsName: course.name, state: state),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  final LessonsListState state;
  final String lessonsName;

  const _MainContent({required this.lessonsName, required this.state});

  @override
  Widget build(BuildContext context) {
    final state = this.state;
    return switch (state) {
      LessonsListLoading() => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 22, left: 22, bottom: 22),
          child: LessonsListWidget(
            lessons: const [],
            isLoading: true,
            isEmpty: false,
            lessonName: lessonsName,
          ),
        ),
      ),
      LessonsListLoaded() => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 22, left: 22, bottom: 22),
          child: LessonsListWidget(
            lessons: state.lessons,
            isLoading: false,
            isEmpty: state.lessons.isEmpty ? true : false,
            lessonName: lessonsName,
          ),
        ),
      ),
    };
  }
}
