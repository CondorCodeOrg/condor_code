import 'package:data/data_sources/remote/models/course_remote.dart';
import 'package:data/data_sources/remote/models/lesson_bundle_remote.dart';
import 'package:data/data_sources/remote/models/lesson_remote.dart';
import 'package:data/data_sources/remote/models/question_remote.dart';
import 'package:data/data_sources/remote/models/task_remote.dart';
import 'package:data/data_sources/remote/models/tester_access_request_remote.dart';
import 'package:data/data_sources/remote/models/user_remote.dart';
import 'package:domain/models/knowledge_base_news_item.dart';

/// Remote service: Firebase logic, REST API calls, etc.
abstract class RemoteDataManager {
  RemoteDataManager();

  UserRemote? get currentUser;

  Stream<UserRemote?> get authStateChanges;

  bool get isUserExist;

  String get currentUserId;

  //Fetch user role from Firestore based on UID
  Future<String?> getUserRole(String uid);

  bool get isEmailPasswordAuth;

  Future<UserRemote> signUpWithEmailPassword({
    required String email,
    required String password,
  });

  Future<void> createUserProfile({
    required String uid,
    required String username,
    required String email,
  });

  Future<UserRemote> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserRemote?> signInWithGoogle();

  Future<void> logout();

  Future<LessonRemote> saveLesson(LessonRemote lesson);

  /// Removes a lesson and all linked tasks/questions.
  ///
  /// Also decrements the parent course `lessonsAmount` when available.
  Future<void> deleteLessonCascade(String lessonId);

  /// Lessons where [LessonRemote.courseId] equals [courseId].
  Future<List<LessonRemote>> fetchLessonsForCourse(String courseId);

  /// Single lesson document by id.
  Future<LessonRemote> fetchLesson(String lessonId);

  Future<List<TaskRemote>> fetchTasksForLesson(String lessonId);

  /// Single task document by id.
  Future<TaskRemote> fetchTask(String taskId);

  Future<List<QuestionRemote>> fetchQuestionsForLesson(String lessonId);

  /// Writes lesson + tasks + questions in one batch.
  ///
  /// **Id semantics:** for the lesson, each task, and each question, an empty
  /// string `id` creates a new Firestore document (auto-generated document id); a
  /// non-empty `id` targets that document for a merge write. The returned
  /// [LessonBundleRemote] uses the resolved ids in every model.
  ///
  /// Before each task/question write, [TaskRemote.lessonId] and
  /// [QuestionRemote.lessonId] are set to the resolved lesson document id.
  Future<LessonBundleRemote> saveLessonBundle({
    required LessonRemote lesson,
    required List<TaskRemote> tasks,
    required List<QuestionRemote> questions,
  });

  /// Sets `sortOrder` on lesson docs to match list index (0, 1, …).
  Future<void> updateLessonsSortOrder({
    required String courseId,
    required List<String> lessonIdsOrdered,
  });

  Future<List<CourseRemote>> fetchAllCourses();

  /// Updates only editable course metadata fields.
  Future<void> updateCourseDetails({
    required String courseId,
    required String name,
    required String imageUrl,
  });

  /// Removes a course and all linked lessons/tasks/questions.
  Future<void> deleteCourseCascade(String courseId);

  Future<CourseRemote> uploadFullCourseBundle({
    required CourseRemote course,
    required List<LessonRemote> lessons,
    required List<TaskRemote> tasks,
    required List<QuestionRemote> questions,
  });

  Future<void> submitTesterAccessRequest();

  Future<TesterAccessRequestRemote?> fetchTesterAccessRequestForUser(
    String userId,
  );

  Future<List<TesterAccessRequestRemote>> fetchPendingTesterAccessRequests();

  Future<void> approveTesterAccessRequest({
    required String requestId,
    required String userId,
  });

  Future<void> rejectTesterAccessRequest({required String requestId});

  Future<List<KnowledgeBaseNewsItem>> fetchKnowledgeBaseNews();

  Future<String> fetchKnowledgeBaseRoadmapJson();
}
