import 'package:data/data_sources/remote/manager/remote_data_manager.dart';
import 'package:data/mappers/lesson_mapper.dart';
import 'package:data/mappers/question_mapper.dart';
import 'package:data/mappers/task_mapper.dart';
import 'package:domain/domain.dart';

int _compareLessonsClientOrder(Lesson a, Lesson b) {
  final byOrder = a.sortOrder.compareTo(b.sortOrder);
  if (byOrder != 0) return byOrder;
  return a.title.toLowerCase().compareTo(b.title.toLowerCase());
}

int _compareLessonItemsClientOrder(LessonItem a, LessonItem b) {
  final byOrder = a.sortOrder.compareTo(b.sortOrder);
  if (byOrder != 0) return byOrder;
  return a.name.toLowerCase().compareTo(b.name.toLowerCase());
}

class LessonsRepositoryImpl implements LessonsRepository {
  LessonsRepositoryImpl({required this.remoteDataManager});

  final RemoteDataManager remoteDataManager;

  @override
  Future<DataResult<Lesson>> getLesson(String lessonId) => safeDataCall(
    dataCall: () async {
      final remote = await remoteDataManager.fetchLesson(lessonId);
      return remote.toDomain();
    },
    processResult: SuccessResult.new,
  );

  @override
  Future<DataResult<List<LessonItem>>> getLessonsItems(String courseId) =>
      safeDataCall(
        dataCall: () async {
          final remotes = await remoteDataManager.fetchLessonsForCourse(
            courseId,
          );
          final items =
              remotes
                  .map(
                    (r) => LessonItem(
                      id: r.id,
                      name: r.title,
                      topic: r.topic,
                      imageUrl: '',
                      sortOrder: r.sortOrder,
                    ),
                  )
                  .toList()
                ..sort(_compareLessonItemsClientOrder);
          return items;
        },
        processResult: SuccessResult.new,
      );

  @override
  Future<DataResult<Lesson>> saveLesson(Lesson lesson) async {
    return safeDataCall(
      dataCall: () async {
        final remote = await remoteDataManager.saveLesson(lesson.toRemote());
        return remote.toDomain();
      },
      processResult: SuccessResult.new,
    );
  }

  @override
  Future<DataResult<List<Lesson>>> fetchLessonsForCourse(String courseId) =>
      safeDataCall(
        dataCall: () async {
          final remotes = await remoteDataManager.fetchLessonsForCourse(
            courseId,
          );
          final list = remotes.map((r) => r.toDomain()).toList()
            ..sort(_compareLessonsClientOrder);
          return list;
        },
        processResult: SuccessResult.new,
      );

  @override
  Future<DataResult<List<Task>>> fetchTasksForLesson(String lessonId) =>
      safeDataCall(
        dataCall: () async {
          final remotes = await remoteDataManager.fetchTasksForLesson(lessonId);
          return remotes.map((r) => r.toDomain()).toList();
        },
        processResult: SuccessResult.new,
      );

  @override
  Future<DataResult<List<Question>>> fetchQuestionsForLesson(String lessonId) =>
      safeDataCall(
        dataCall: () async {
          final remotes = await remoteDataManager.fetchQuestionsForLesson(
            lessonId,
          );
          return remotes.map((r) => r.toDomain()).toList();
        },
        processResult: SuccessResult.new,
      );

  /// Same id semantics as [LessonsRepository.saveLessonBundle].
  ///
  /// Delegates to [RemoteDataManager.saveLessonBundle] (batch + merge writes).
  @override
  Future<DataResult<LessonBundle>> saveLessonBundle({
    required Lesson lesson,
    required List<Task> tasks,
    required List<Question> questions,
  }) => safeDataCall(
    dataCall: () async {
      final bundle = await remoteDataManager.saveLessonBundle(
        lesson: lesson.toRemote(),
        tasks: tasks.map((t) => t.toRemote()).toList(),
        questions: questions.map((q) => q.toRemote()).toList(),
      );
      return LessonBundle(
        lesson: bundle.lesson.toDomain(),
        tasks: bundle.tasks.map((t) => t.toDomain()).toList(),
        questions: bundle.questions.map((q) => q.toDomain()).toList(),
      );
    },
    processResult: SuccessResult.new,
  );

  /// Same remote batch as [saveLessonBundle] with empty tasks and questions;
  /// returns only the resolved [Lesson].
  @override
  Future<DataResult<Lesson>> saveCompleteLesson(Lesson lesson) => safeDataCall(
    dataCall: () async {
      final bundle = await remoteDataManager.saveLessonBundle(
        lesson: lesson.toRemote(),
        tasks: const [],
        questions: const [],
      );
      return bundle.lesson.toDomain();
    },
    processResult: SuccessResult.new,
  );

  @override
  Future<DataResult<void>> deleteLessonCascade(String lessonId) => safeDataCall(
    dataCall: () async {
      await remoteDataManager.deleteLessonCascade(lessonId);
      return null;
    },
    processResult: (_) => SuccessResult<void>(null),
  );

  @override
  Future<DataResult<void>> updateLessonsSortOrder({
    required String courseId,
    required List<String> lessonIdsOrdered,
  }) => safeDataCall(
    dataCall: () async {
      await remoteDataManager.updateLessonsSortOrder(
        courseId: courseId,
        lessonIdsOrdered: lessonIdsOrdered,
      );
      return null;
    },
    processResult: (_) => SuccessResult<void>(null),
  );
}
