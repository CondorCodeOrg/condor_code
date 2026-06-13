import 'package:data/data_sources/mock/mock_data/mock_data.dart';
import 'package:data/data_sources/remote/manager/remote_data_manager.dart';
import 'package:data/data_sources/remote/models/course_remote.dart';
import 'package:data/data_sources/remote/models/lesson_bundle_remote.dart';
import 'package:data/data_sources/remote/models/lesson_remote.dart';
import 'package:data/data_sources/remote/models/question_remote.dart';
import 'package:data/data_sources/remote/models/task_remote.dart';
import 'package:data/data_sources/remote/models/tester_access_request_remote.dart';
import 'package:data/data_sources/remote/models/user_remote.dart';
import 'package:domain/models/enums/knowledge_base_news_category.dart';
import 'package:domain/models/knowledge_base_news_item.dart';

class MockRemoteDataManager implements RemoteDataManager {
  static final _mockUser = mockUser;
  static final _mockCourses = mockCourses;
  static final _mockLessons = mockLessons;
  static final _mockTasks = mockTasks;
  static final _mockQuestions = mockQuestions;

  @override
  Future<void> approveTesterAccessRequest({
    required String requestId,
    required String userId,
  }) {
    return Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Stream<UserRemote?> get authStateChanges => Stream.value(_mockUser);

  @override
  Future<void> createUserProfile({
    required String uid,
    required String username,
    required String email,
  }) {
    return Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  UserRemote? get currentUser => _mockUser;

  @override
  String get currentUserId => _mockUser.id;

  @override
  Future<void> deleteCourseCascade(String courseId) {
    return Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> deleteLessonCascade(String lessonId) {
    return Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<List<CourseRemote>> fetchAllCourses() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => List.unmodifiable(_mockCourses),
    );
  }

  @override
  Future<LessonRemote> fetchLesson(String lessonId) {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => _mockLessons[lessonId] ?? _mockLessons.values.first,
    );
  }

  @override
  Future<List<LessonRemote>> fetchLessonsForCourse(String courseId) {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => _mockLessons.values.where((l) => l.courseId == courseId).toList(),
    );
  }

  @override
  Future<List<TesterAccessRequestRemote>> fetchPendingTesterAccessRequests() {
    return Future.delayed(const Duration(milliseconds: 500), () => const []);
  }

  @override
  Future<List<QuestionRemote>> fetchQuestionsForLesson(String lessonId) {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => List.unmodifiable(_mockQuestions),
    );
  }

  @override
  Future<TaskRemote> fetchTask(String taskId) {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => _mockTasks[taskId] ?? _mockTasks.values.first,
    );
  }

  @override
  Future<List<TaskRemote>> fetchTasksForLesson(String lessonId) {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => _mockTasks.values.where((t) => t.lessonId == lessonId).toList(),
    );
  }

  @override
  Future<TesterAccessRequestRemote?> fetchTesterAccessRequestForUser(
    String userId,
  ) {
    return Future.delayed(const Duration(milliseconds: 500), () => null);
  }

  @override
  Future<String?> getUserRole(String uid) {
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _mockUser.role,
    );
  }

  @override
  bool get isEmailPasswordAuth => true;

  @override
  bool get isUserExist => true;

  @override
  Future<void> logout() {
    return Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> rejectTesterAccessRequest({required String requestId}) {
    return Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<LessonRemote> saveLesson(LessonRemote lesson) {
    return Future.delayed(const Duration(milliseconds: 500), () => lesson);
  }

  @override
  Future<LessonBundleRemote> saveLessonBundle({
    required LessonRemote lesson,
    required List<TaskRemote> tasks,
    required List<QuestionRemote> questions,
  }) {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => LessonBundleRemote(
        lesson: lesson,
        tasks: tasks,
        questions: questions,
      ),
    );
  }

  @override
  Future<UserRemote> signInWithEmailPassword({
    required String email,
    required String password,
  }) {
    return Future.delayed(const Duration(milliseconds: 500), () => _mockUser);
  }

  @override
  Future<UserRemote?> signInWithGoogle() {
    return Future.delayed(const Duration(milliseconds: 500), () => _mockUser);
  }

  @override
  Future<UserRemote> signUpWithEmailPassword({
    required String email,
    required String password,
  }) {
    return Future.delayed(const Duration(milliseconds: 500), () => _mockUser);
  }

  @override
  Future<void> submitTesterAccessRequest() {
    return Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> updateCourseDetails({
    required String courseId,
    required String name,
    required String imageUrl,
  }) {
    return Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> updateLessonsSortOrder({
    required String courseId,
    required List<String> lessonIdsOrdered,
  }) {
    return Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<CourseRemote> uploadFullCourseBundle({
    required CourseRemote course,
    required List<LessonRemote> lessons,
    required List<TaskRemote> tasks,
    required List<QuestionRemote> questions,
  }) {
    return Future.delayed(const Duration(milliseconds: 500), () => course);
  }

  @override
  Future<List<KnowledgeBaseNewsItem>> fetchKnowledgeBaseNews() {
    return Future.delayed(
      const Duration(milliseconds: 400),
      () => const [
        KnowledgeBaseNewsItem(
          id: 'kb-1',
          category: KnowledgeBaseNewsCategory.article,
          relativeTimeLabel: '2 год тому',
          title: 'Нові матеріали: віджети та дерево UI',
          snippet:
              'У розділі ресурсів зʼявилися статті про базові віджети та як Flutter будує дерево віджетів.',
        ),
        KnowledgeBaseNewsItem(
          id: 'kb-2',
          category: KnowledgeBaseNewsCategory.roadmap,
          relativeTimeLabel: '1 день тому',
          title: 'Оновлено етап «State Management»',
          snippet:
              'Інтерактивний роадмап: додано вузли про Provider, Riverpod та залежність від масштабу проєкту.',
        ),
        KnowledgeBaseNewsItem(
          id: 'kb-3',
          category: KnowledgeBaseNewsCategory.announcement,
          relativeTimeLabel: '3 дні тому',
          title: 'База знань у розробці',
          snippet:
              'Ми збираємо структуровані статті, відео та посилання для новачків у Dart і Flutter.',
        ),
        KnowledgeBaseNewsItem(
          id: 'kb-4',
          category: KnowledgeBaseNewsCategory.article,
          relativeTimeLabel: '5 днів тому',
          title: 'Навігація: GoRouter у прикладах',
          snippet:
              'Додано добірку прикладів і типових помилок при оголошенні маршрутів.',
        ),
      ],
    );
  }

  @override
  Future<String> fetchKnowledgeBaseRoadmapJson() {
    return Future.delayed(
      const Duration(milliseconds: 250),
      () => mockKnowledgeBaseRoadmapJson,
    );
  }
}
