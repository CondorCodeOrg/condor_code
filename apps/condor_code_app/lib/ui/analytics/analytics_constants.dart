/// Firebase Analytics event names used across the app.
///
/// All event logging must reference these constants to avoid typos
/// and keep the analytics schema in one place.
class AnalyticsEventName {
  AnalyticsEventName._();

  static const String screenView = 'screen_view';
  static const String navClick = 'nav_click';
  static const String buttonClick = 'button_click';
  static const String openCourse = 'open_course';
  static const String selectLesson = 'select_lesson';
  static const String openTask = 'open_task';
  static const String userLogin = 'user_login';
  static const String userLogout = 'user_logout';
  static const String wishFlutterCourse = 'wish_flutter_course';
}

/// Firebase Analytics event parameter keys.
///
/// Every event parameter should use one of these constants so the
/// Firebase Console Custom Definitions line up with the code.
class AnalyticsPropertyName {
  AnalyticsPropertyName._();

  /// Custom session id attached to every event (prefixed with `cc_`
  /// to avoid collision with the reserved `session_id` name).
  static const String sessionId = 'cc_session_id';

  static const String screenName = 'screen_name';
  static const String screenClass = 'screen_class';
  static const String destination = 'destination';
  static const String buttonId = 'button_id';
  static const String courseId = 'course_id';
  static const String courseName = 'course_name';
  static const String lessonId = 'lesson_id';
  static const String lessonTitle = 'lesson_title';
  static const String taskId = 'task_id';
  static const String environment = 'environment';
  static const String userId = 'user_id';
  static const String firebaseScreen = 'firebase_screen';
  static const String firebaseScreenClass = 'firebase_screen_class';
  static const String screenId = 'screen_id';
  static const String screenTitle = 'screen_title';
}

/// Well-known button identifiers used with [AnalyticsEventName.buttonClick].
class AnalyticsButtonId {
  AnalyticsButtonId._();

  static const String homeLearnMore = 'home_learn_more';
  static const String checkKnowledge = 'check_knowledge';
}

/// Well-known route destinations used with [AnalyticsEventName.navClick].
class AnalyticsDestination {
  AnalyticsDestination._();

  static const String home = '/home';
  static const String courses = '/courses';
  static const String contacts = '/contacts';
  static const String knowledgeBaseHome = '/knowledge-base/home';
  static const String knowledgeBaseRoadmap = '/knowledge-base/roadmap';
  static const String knowledgeBaseResources = '/knowledge-base/resources';
}
