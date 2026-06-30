import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/navigation/route_constants.dart';
import 'package:condor_code/ui/screens/course/course_cubit/course_cubit.dart';
import 'package:condor_code/ui/screens/course/course_cubit/course_state.dart';
import 'package:condor_code/ui/screens/course/widgets/course_action_panel.dart';
import 'package:condor_code/ui/screens/course/widgets/course_lesson_details_panel.dart';
import 'package:condor_code/ui/screens/course/widgets/course_lessons_side_panel.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:condor_code/ui/widgets/screen_back_button.dart';
import 'package:condor_code/ui/widgets/side_panel_screen_widget.dart';
import 'package:condor_code/ui/widgets/snack_bar/snack_bar_producer_widget.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_kit/ui_kit.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({
    super.key,
    required this.courseId,
    required this.courseName,
    this.initialLessonId,
  });

  final String courseId;
  final String courseName;
  final String? initialLessonId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<CourseCubit>(param1: courseId, param2: initialLessonId),
      child: _CourseScreenBody(
        courseId: courseId,
        courseName: courseName,
        routeLessonId: initialLessonId,
      ),
    );
  }
}

class _CourseScreenBody extends StatelessWidget {
  const _CourseScreenBody({
    required this.courseId,
    required this.courseName,
    required this.routeLessonId,
  });

  final String courseId;
  final String courseName;

  /// Lesson id from this route instance (URL); used so the sidebar matches the
  /// address bar immediately and per stacked page, not only after cubit loads.
  final String? routeLessonId;

  /// Courses whose lessons list has already been loaded in this session.
  /// Prevents flashing the skeleton again when navigating between lessons.
  static final _loadedCourseLessons = <String>{};

  /// Cached lessons per course so the list never flashes empty between pushes.
  static final _lessonsCache = <String, List<LessonItem>>{};

  /// Whether the lessons skeleton should be shown for [courseId].
  /// Once [state.lessons] is non-empty the course is marked as loaded.
  static bool _showLessonsSkeleton(CourseState state, String courseId) {
    if (state.lessons.isNotEmpty) {
      _loadedCourseLessons.add(courseId);
      _lessonsCache[courseId] = state.lessons;
      return false;
    }
    return state.isLessonsLoading && !_loadedCourseLessons.contains(courseId);
  }

  /// Returns the freshest lessons, falling back to the cache so the list never
  /// briefly disappears when a new [CourseCubit] starts loading.
  static List<LessonItem> _effectiveLessons(
    CourseState state,
    String courseId,
  ) {
    if (state.lessons.isNotEmpty) return state.lessons;
    return _lessonsCache[courseId] ?? state.lessons;
  }

  void _onLessonSelected(BuildContext context, String lessonId) {
    final currentLessonId = GoRouterState.of(
      context,
    ).pathParameters['lessonId'];
    if (currentLessonId == lessonId) return;

    context.push(
      '${RouteConstants.course}/$courseId/$lessonId',
      extra: courseName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SnackBarProducerWidget(
          child: BlocBuilder<CourseCubit, CourseState>(
            builder: (context, state) {
              void onSelect(String id) => _onLessonSelected(context, id);

              return SidePanelScreenWidget(
                sidePanelBuilder: (collapsed) => _CourseWideLessonsPanel(
                  collapsed: collapsed,
                  state: state,
                  sidebarSelectedLessonId: _effectiveSidebarLessonId(
                    state,
                    routeLessonId,
                  ),
                  onLessonSelected: onSelect,
                  width: width,
                  courseId: courseId,
                ),
                body: CourseLessonDetailsPanel(
                  lesson: state.selectedLesson,
                  isLoading: state.isLessonDetailsLoading,
                ),
                actionsContentBuilder: (isExpanded) => CourseActionPanel(
                  lessonId: state.selectedLesson?.id,
                  courseId: courseId,
                  courseName: courseName,
                  expanded: isExpanded,
                  isTasksExist: state.isTasksExist,
                  lesson: state.selectedLesson,
                ),
                header: _CourseHeader(courseName: courseName),
                narrowLayout: _NarrowLayout(
                  state: state,
                  courseId: courseId,
                  courseName: courseName,
                  sidebarSelectedLessonId: _effectiveSidebarLessonId(
                    state,
                    routeLessonId,
                  ),
                  onLessonSelected: onSelect,
                ),
                actionsContentWidth: 220,
                contentPadding: const EdgeInsets.all(16),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CourseWideLessonsPanel extends SidePanel {
  _CourseWideLessonsPanel({
    required super.collapsed,
    required CourseState state,
    required String? sidebarSelectedLessonId,
    required ValueChanged<String> onLessonSelected,
    required double width,
    required String courseId,
  }) : super(
         expandedWidth: 280,
         collapsedWidth: 62,
         isLoading: _CourseScreenBody._showLessonsSkeleton(state, courseId),
         loadingSkeletonName: width > 700 && width < 1100
             ? CondorHollowSkeletonIds.lessonsListMiddleScreen
             : CondorHollowSkeletonIds.lessonsListFullScreen,
         header: SidePanelHeader(
           icon: Icons.list_alt_rounded,
           title: localization.courseLessons,
         ),
         child: CourseLessonsList(
           lessons: _CourseScreenBody._effectiveLessons(state, courseId),
           selectedLessonId: sidebarSelectedLessonId,
           onLessonSelected: onLessonSelected,
           collapsed: collapsed,
           courseId: courseId,
         ),
       );
}

class _CourseNarrowLessonsPanel extends SidePanel {
  _CourseNarrowLessonsPanel({
    required CourseState state,
    required String? sidebarSelectedLessonId,
    required ValueChanged<String> onLessonSelected,
    required String courseId,
  }) : super(
         collapsed: false,
         compact: true,
         isLoading: _CourseScreenBody._showLessonsSkeleton(state, courseId),
         loadingSkeletonName: CondorHollowSkeletonIds.lessonsListFullScreen,
         header: SidePanelHeader(
           icon: Icons.list_alt_rounded,
           title: localization.courseLessons,
         ),
         child: SizedBox(
           height: 160,
           child: CourseLessonsList(
             lessons: _CourseScreenBody._effectiveLessons(state, courseId),
             selectedLessonId: sidebarSelectedLessonId,
             onLessonSelected: onLessonSelected,
             shrinkWrap: false,
             courseId: courseId,
           ),
         ),
       );
}

class _CourseHeader extends StatelessWidget {
  const _CourseHeader({required this.courseName, this.isNarrowLayout = false});

  final String courseName;
  final bool isNarrowLayout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.grey600.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.grey400.withValues(alpha: 0.45)),
      ),
      child: Row(
        children: [
          if (isNarrowLayout) const SizedBox(width: 50),
          ScreenBackButton(onPressed: () => _exitCourseViaAppBar(context)),
          const SizedBox(width: 10),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.neon.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.school_rounded,
              color: AppColors.neon,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              courseName,
              style: AppTextStyles.h2.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({
    required this.state,
    required this.courseId,
    required this.courseName,
    required this.sidebarSelectedLessonId,
    required this.onLessonSelected,
  });

  final CourseState state;
  final String courseId;
  final String courseName;
  final String? sidebarSelectedLessonId;
  final ValueChanged<String> onLessonSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CourseHeader(courseName: courseName, isNarrowLayout: true),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _CourseNarrowLessonsPanel(
                  state: state,
                  sidebarSelectedLessonId: sidebarSelectedLessonId,
                  onLessonSelected: onLessonSelected,
                  courseId: courseId,
                ),
                const SizedBox(height: 12),
                CourseLessonDetailsPanel(
                  lesson: state.selectedLesson,
                  isLoading: state.isLessonDetailsLoading,
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: CourseActionPanel(
            lessonId: state.selectedLesson?.id,
            courseId: courseId,
            courseName: courseName,
            isTasksExist: state.isTasksExist,
            lesson: state.selectedLesson,
          ),
        ),
      ],
    );
  }
}

/// App bar back: exits the **entire** course flow at once (does not walk the
/// pushed lesson stack). Browser Back still pops one history entry per lesson.
void _exitCourseViaAppBar(BuildContext context) {
  context.go(RouteConstants.courses);
}

/// Sidebar highlight tracks this route’s lesson segment first so it matches
/// the URL during fetch and when using browser history; falls back to cubit.
String? _effectiveSidebarLessonId(CourseState state, String? routeLessonId) {
  final route = routeLessonId;
  if (route != null && route.isNotEmpty && route != 'first') return route;
  return state.selectedLesson?.id;
}
