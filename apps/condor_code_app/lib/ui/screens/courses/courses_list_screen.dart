import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/analytics_constants.dart';
import 'package:condor_code/ui/screens/courses/courses_cubit/courses_cubit.dart';
import 'package:condor_code/ui/screens/courses/courses_cubit/courses_state.dart';
import 'package:condor_code/ui/screens/courses/widgets/courses_list_widget.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/snack_bar/snack_bar_producer_widget.dart';
import 'package:condor_code/ui/widgets/top_navigation_bar.dart';
import 'package:flutter/material.dart';

class CoursesListScreen extends StatefulWidget {
  const CoursesListScreen({super.key});

  @override
  State<CoursesListScreen> createState() => _CoursesListScreenState();
}

class _CoursesListScreenState extends State<CoursesListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  static const _tabsAmount = 2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabsAmount, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1024;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: !isDesktop
          ? TopNavigationBar(text: localization.courses, isLeading: false)
          : null,
      body: SafeArea(
        child: SnackBarProducerWidget(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop
                    ? MediaQuery.of(context).size.width * 0.88
                    : double.infinity,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 40 : 22,
                        vertical: isDesktop ? 32 : 22,
                      ),
                      child: Column(
                        children: [Expanded(child: _CoursesScreen())],
                      ),
                    ),
                  ),
                  Divider(height: 0.6, color: context.colors.surface),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CoursesScreen extends StatelessWidget {
  const _CoursesScreen();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<CoursesCubit>(),
      child: BlocListener<CoursesCubit, CoursesState>(
        listenWhen: (previous, current) =>
            current.openCommand != null &&
            current.openCommand!.seq != previous.openCommand?.seq,
        listener: (context, state) {
          final cmd = state.openCommand!;
          di<Analytics>().logEvent(AnalyticsEventName.openCourse, {
            AnalyticsPropertyName.courseId: cmd.courseId,
            AnalyticsPropertyName.courseName: cmd.courseNameExtra,
          });
          context.go(cmd.location, extra: cmd.courseNameExtra);
          context.read<CoursesCubit>().consumeOpenCommand();
        },
        child: BlocBuilder<CoursesCubit, CoursesState>(
          builder: (context, state) => CoursesListWidget(
            courses: state.courses,
            isLoading: state.isLoading,
            isEmpty: state.courses.isEmpty,
            onCourseSelected: (Course course) =>
                context.read<CoursesCubit>().openCourse(course),
          ),
        ),
      ),
    );
  }
}
