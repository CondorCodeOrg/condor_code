import 'package:condor_code/config/app_config.dart';
import 'package:condor_code/di/provider_manager.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/analytics_navigator_observer.dart';
import 'package:condor_code/ui/navigation/route_constants.dart';
import 'package:condor_code/ui/navigation/route_observers.dart';
import 'package:condor_code/ui/navigation/staging_gate_notifier.dart';
import 'package:condor_code/ui/screens/contacts/contacts_screen.dart';
import 'package:condor_code/ui/screens/course/course_screen.dart';
import 'package:condor_code/ui/screens/courses/courses_list_screen.dart';
import 'package:condor_code/ui/screens/courses/screens/empty_course_screen.dart';
import 'package:condor_code/ui/screens/home/home.dart';
import 'package:condor_code/ui/screens/knowledge_base/knowledge_base_home_screen.dart';
import 'package:condor_code/ui/screens/knowledge_base/knowledge_base_resources_screen.dart';
import 'package:condor_code/ui/screens/knowledge_base/knowledge_base_shell.dart';
import 'package:condor_code/ui/screens/knowledge_base/roadmap/knowledge_base_roadmap_screen.dart';
import 'package:condor_code/ui/screens/knowledge_check/knowledge_check_screen.dart';
import 'package:condor_code/ui/screens/lesson_details/lesson_details_screen.dart';
import 'package:condor_code/ui/screens/lessons_list/lessons_list_screen.dart';
import 'package:condor_code/ui/screens/main/main_screen.dart';
import 'package:condor_code/ui/screens/staging/only_testers_screen.dart';
import 'package:condor_code/ui/screens/staging/staging_login_screen.dart';
import 'package:condor_code/ui/screens/task_answer/task_answer_screen.dart';
import 'package:condor_code/ui/screens/task_details/task_details_screen.dart';
import 'package:condor_code/ui/screens/tasks_list/tasks_list_screen.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:condor_code/ui/screens/test_selection/test_selection_screen.dart';
import 'package:condor_code/ui/screens/test_selection/test_selection_cubit.dart';
import 'package:condor_code/ui/screens/test/test_screen.dart';
import 'package:condor_code/ui/screens/result_screen.dart';
import 'package:condor_code/ui/screens/heart_information_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

///TODO uncomment if this logic will be need
// final _sectionNavigatorKey = GlobalKey<NavigatorState>();

bool get _isDesktopWeb {
  if (!kIsWeb) return false;

  final view = WidgetsBinding.instance.platformDispatcher.views.first;
  final logicalWidth = view.physicalSize.width / view.devicePixelRatio;

  return logicalWidth >= 1024;
}

BuildContext get globalContext => _rootNavigatorKey.currentContext!;

String _initialLocation(AppConfig appConfig) {
  if (appConfig.isStaging) return RouteConstants.stagingLogin;
  return _isDesktopWeb ? RouteConstants.home : RouteConstants.courses;
}

CustomTransitionPage<void> _fadeTransitionPage({
  required GoRouterState state,
  required Widget child,
  LocalKey? pageKey,
}) {
  return CustomTransitionPage<void>(
    key: pageKey ?? state.pageKey,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        ),
        child: child,
      );
    },
  );
}

List<NavigatorObserver> _getObservers(AppConfig appConfig) =>
    <NavigatorObserver>[
      if (appConfig.isProd || appConfig.isStaging) ...[
        AnalyticsNavigatorObserver(di<Analytics>()),
      ],
    ];

GoRouter getRouter(AppConfig appConfig) => GoRouter(
  navigatorKey: _rootNavigatorKey,
  observers: _getObservers(appConfig),
  initialLocation: _initialLocation(appConfig),
  refreshListenable: appConfig.isStaging ? di<StagingGateNotifier>() : null,
  redirect: (context, state) {
    final p = state.uri.path;
    if (!appConfig.isStaging && p == RouteConstants.stagingLogin) {
      return _isDesktopWeb ? RouteConstants.home : RouteConstants.courses;
    }
    if (p == RouteConstants.knowledgeBase ||
        p == RouteConstants.knowledgeBaseTrailingSlash) {
      return RouteConstants.knowledgeBaseHome;
    }

    if (appConfig.isStaging) {
      final gate = di<StagingGateNotifier>();

      if (gate.roleGatePending) {
        return null;
      }

      if (!gate.hasFirebaseSession) {
        if (p == RouteConstants.stagingLogin) return null;
        return RouteConstants.stagingLogin;
      }

      if (gate.shouldBlockStagingAccess && p != RouteConstants.onlyTesters) {
        return RouteConstants.onlyTesters;
      }

      if (!gate.shouldBlockStagingAccess && p == RouteConstants.stagingLogin) {
        return _isDesktopWeb ? RouteConstants.home : RouteConstants.courses;
      }

      if (!gate.shouldBlockStagingAccess && p == RouteConstants.onlyTesters) {
        return _isDesktopWeb ? RouteConstants.home : RouteConstants.courses;
      }
    }

    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: RouteConstants.stagingLogin,
      builder: (context, state) => const StagingLoginScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => MainScreen(navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteConstants.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          observers: [coursesBranchRouteObserver],
          routes: [
            GoRoute(
              path: RouteConstants.courses,
              builder: (context, state) => const CoursesListScreen(),
            ),
            GoRoute(
              path: '${RouteConstants.course}/:courseId/:lessonId',
              pageBuilder: (context, state) {
                final courseId = state.pathParameters['courseId'] ?? '1';
                final lessonId = state.pathParameters['lessonId'] ?? '';
                final courseName = state.extra as String? ?? 'Dart/Flutter';
                return _fadeTransitionPage(
                  state: state,
                  child: CourseScreen(
                    courseId: courseId,
                    courseName: courseName,
                    initialLessonId: lessonId.isEmpty ? null : lessonId,
                  ),
                );
              },
            ),
            GoRoute(
              path: RouteConstants.emptyCourseScreen,
              builder: (BuildContext context, GoRouterState state) {
                final courseName = state.extra as String? ?? 'Dart/Flutter';
                return EmptyCourseScreen(courseName: courseName);
              },
            ),
            GoRoute(
              path:
                  '${RouteConstants.knowledgeCheck}/:courseId/lessons/:lessonId/tasks/:taskId',
              pageBuilder: (context, state) {
                final courseId = state.pathParameters['courseId'] ?? '1';
                final lessonId = state.pathParameters['lessonId'] ?? '1';
                final taskId = state.pathParameters['taskId'] ?? '';
                final courseName = state.extra as String? ?? 'Dart/Flutter';
                return _fadeTransitionPage(
                  state: state,
                  child: KnowledgeCheckScreen(
                    courseId: courseId,
                    lessonId: lessonId,
                    courseName: courseName,
                    initialTaskId: taskId.isEmpty ? null : taskId,
                  ),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            ShellRoute(
              builder: (context, state, child) =>
                  KnowledgeBaseShell(child: child),
              routes: [
                GoRoute(
                  path: RouteConstants.knowledgeBaseHome,
                  pageBuilder: (context, state) => _fadeTransitionPage(
                    state: state,
                    child: const KnowledgeBaseHomeScreen(),
                  ),
                ),
                GoRoute(
                  path: RouteConstants.knowledgeBaseRoadmap,
                  pageBuilder: (context, state) => _fadeTransitionPage(
                    state: state,
                    child: const KnowledgeBaseRoadmapScreen(),
                  ),
                ),
                GoRoute(
                  path: RouteConstants.knowledgeBaseResources,
                  pageBuilder: (context, state) => _fadeTransitionPage(
                    state: state,
                    child: const KnowledgeBaseResourcesScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteConstants.contactsScreen,
              builder: (context, state) => const ContactsScreen(),
            ),
          ],
        ),
      ],
    ),

    ///TODO uncomment if this logic will be need
    // StatefulShellRoute.indexedStack(
    //   builder: (builder, context, navigationShell) =>
    //       MainScreen(navigationShell),
    //   branches: [
    //     StatefulShellBranch(
    //       navigatorKey: _sectionNavigatorKey,
    //       routes: <RouteBase>[
    //         GoRoute(
    //           path: '/courses',
    //           builder: (context, state) => const CoursesScreen(),
    //         ),
    //       ],
    //     ),
    //     StatefulShellBranch(
    //       routes: <RouteBase>[
    //         GoRoute(
    //           path: '/profile',
    //           builder: (context, state) => const ProfileScreen(),
    //         ),
    //       ],
    //     ),
    //   ],
    //     ),
    GoRoute(
      path: RouteConstants.onlyTesters,
      builder: (context, state) => const OnlyTestersScreen(),
    ),
    GoRoute(
      path: RouteConstants.lessons,
      builder: (BuildContext context, GoRouterState state) {
        return LessonsListScreen(
          // TODO: end this logic later.
          course: Course(id: '', name: '', imageUrl: '', lessonsAmount: 1),
        );
      },
    ),
    GoRoute(
      path: RouteConstants.lessonDetails,
      builder: (BuildContext context, GoRouterState state) {
        return const LessonDetailsScreen(lessonId: '1');
      },
    ),
    GoRoute(
      path: RouteConstants.tasksListScreen,
      builder: (BuildContext context, GoRouterState state) {
        // TODO: end this logic later.
        return const TasksListScreen(
          lesson: Lesson(
            id: '',
            title: '',
            topic: '',
            youtubeUrl: '',
            description: '',
            isYouTubeLesson: true,
            courseId: '',
          ),
        );
      },
    ),
    GoRoute(
      path: RouteConstants.taskDetails,
      builder: (BuildContext context, GoRouterState state) {
        return const TaskDetailsScreen(taskId: '1');
      },
    ),
    GoRoute(
      path: RouteConstants.taskAnswerScreen,
      builder: (BuildContext context, GoRouterState state) {
        final answer = state.extra as Answer;
        return TaskAnswerScreen(answer: answer);
      },
    ),
    GoRoute(
      path: RouteConstants.tests, // /course/:courseId/:lessonId/tests
      builder: (context, state) {
        final courseId = state.pathParameters['courseId']!;
        final lessonId = state.pathParameters['lessonId']!;
        return BlocProvider(
          create: (_) => di<TestSelectionCubit>(param1: lessonId),
          child: TestSelectionScreen(courseId: courseId, lessonId: lessonId),
        );
      },
      routes: [
        GoRoute(
          path: ':testId', // nested: /course/:courseId/:lessonId/tests/:testId
          builder: (context, state) {
            final courseId = state.pathParameters['courseId'] ?? '';
            final testId = state.pathParameters['testId']!;
            return TestScreen(lessonId: testId, courseId: courseId);
          },
          routes: [
            GoRoute(
              path:
                  'result', // nested: /course/:courseId/:lessonId/tests/:testId/result
              builder: (context, state) {
                final courseId = state.pathParameters['courseId'] ?? '';
                final lessonId = state.pathParameters['lessonId'] ?? '';
                final extra = state.extra as Map<String, dynamic>;
                return ResultScreen(
                  seconds: extra['seconds'] as int,
                  correctAnswer: extra['correctAnswer'] as int,
                  inCorrectAnswer: extra['inCorrectAnswer'] as int,
                  courseId: courseId,
                  lessonId: lessonId,
                );
              },
            ),
            GoRoute(
              path:
                  'hearts', // nested: /course/:courseId/:lessonId/tests/:testId/hearts
              builder: (context, state) => const HeartInformationScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
