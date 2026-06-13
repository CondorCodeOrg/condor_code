import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Typed routes for [GoRouter] — use [go] / [push] instead of raw path strings.
///
/// Paths are defined once per route class (same pattern as admin `GoRouteData.location`).
sealed class CondorRoute {
  const CondorRoute();

  /// Location string for [GoRouter.go] / [GoRouter.push].
  String get location;
}

extension CondorRouteNavigation on CondorRoute {
  void go(BuildContext context) => context.go(location);

  Future<T?> push<T extends Object?>(BuildContext context) =>
      context.push<T>(location);
}

// --- Shell / tabs ---

final class HomeWebRoute extends CondorRoute {
  const HomeWebRoute();

  static const path = '/homeWeb';

  @override
  String get location => path;
}

final class CoursesRoute extends CondorRoute {
  const CoursesRoute();

  static const path = '/courses';

  @override
  String get location => path;
}

final class ContactsScreenRoute extends CondorRoute {
  const ContactsScreenRoute();

  static const path = '/contactsScreen';

  @override
  String get location => path;
}

// --- Stack routes (pushed on top of shell) ---

final class CourseDetailsRoute extends CondorRoute {
  const CourseDetailsRoute(this.courseId);

  final String courseId;

  static const path = '/courseDetails/:courseId';

  @override
  String get location => '/courseDetails/$courseId';

  static Future<T?> pushWithCourse<T extends Object?>(
    BuildContext context,
    Course course,
  ) => context.push<T>(CourseDetailsRoute(course.id).location, extra: course);
}

final class LessonsListRoute extends CondorRoute {
  const LessonsListRoute(this.courseId);

  final String courseId;

  static const path = '/lessons/:courseId';

  @override
  String get location => '/lessons/$courseId';

  static Future<T?> pushWithLessonsTitle<T extends Object?>(
    BuildContext context, {
    required String courseId,
    required String lessonsName,
  }) =>
      context.push<T>(LessonsListRoute(courseId).location, extra: lessonsName);
}

final class LessonDetailsRoute extends CondorRoute {
  const LessonDetailsRoute();

  static const path = '/lessonDetails';

  @override
  String get location => path;
}

final class TasksListRoute extends CondorRoute {
  const TasksListRoute();

  static const path = '/tasksListScreen';

  @override
  String get location => path;
}

final class TaskDetailsRoute extends CondorRoute {
  const TaskDetailsRoute();

  static const path = '/taskDetails';

  @override
  String get location => path;
}

final class TaskAnswerRoute extends CondorRoute {
  const TaskAnswerRoute();

  static const path = '/taskAnswerScreen';

  @override
  String get location => path;

  static Future<T?> pushWithAnswer<T extends Object?>(
    BuildContext context,
    Answer answer,
  ) => context.push<T>(path, extra: answer);
}
