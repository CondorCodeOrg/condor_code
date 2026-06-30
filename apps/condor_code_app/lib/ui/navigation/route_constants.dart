/// Central definitions for [GoRouter] paths. Use these instead of raw strings.
class RouteConstants {
  RouteConstants._();

  static const String home = '/home';
  static const String courses = '/courses';
  static const String emptyCourseScreen = '/emptyCourseScreen';
  static const String contactsScreen = '/contactsScreen';

  static const String course = '/course';
  static const String lessons = '/lessons';
  static const String lessonDetails = '/lessonDetails';
  static const String tasksListScreen = '/tasksListScreen';
  static const String taskDetails = '/taskDetails';
  static const String taskAnswerScreen = '/taskAnswerScreen';

  /// Staging-only screen when the signed-in user is not `tester` or `admin` (Firestore role).
  static const String onlyTesters = '/onlyTesters';

  /// Staging-only sign-in (Firebase Auth); dev/prod skip this flow.
  static const String stagingLogin = '/stagingLogin';

  static const String knowledgeCheck = '/courses';

  /// Knowledge base root (redirects to [knowledgeBaseHome]).
  static const String knowledgeBase = '/knowledgeBase';

  static const String knowledgeBaseTrailingSlash = '/knowledgeBase/';
  static const String knowledgeBaseHome = '/knowledgeBase/home';
  static const String knowledgeBaseRoadmap = '/knowledgeBase/roadmap';
  static const String knowledgeBaseResources = '/knowledgeBase/resources';
  static const String lessonSummary = '/lesson-summary';
}
