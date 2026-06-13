import 'package:domain/data_result/data_result.dart';
import 'package:domain/models/lesson.dart';
import 'package:domain/models/lesson_bundle.dart';
import 'package:domain/models/lesson_item.dart';
import 'package:domain/models/question.dart';
import 'package:domain/models/task.dart';

abstract class LessonsRepository {
  Future<DataResult<Lesson>> getLesson(String lessonId);

  Future<DataResult<List<LessonItem>>> getLessonsItems(String courseId);

  Future<DataResult<Lesson>> saveLesson(Lesson lesson);

  /// Loads all lessons for a course from Firestore (`courseId` field).
  Future<DataResult<List<Lesson>>> fetchLessonsForCourse(String courseId);

  Future<DataResult<List<Task>>> fetchTasksForLesson(String lessonId);

  Future<DataResult<List<Question>>> fetchQuestionsForLesson(String lessonId);

  /// Persists lesson + tasks + questions in one remote batch; returns resolved ids.
  ///
  /// **Id semantics:** use an empty string for a **new** lesson, task, or question
  /// so the data layer allocates a new Firestore document id. A non-empty id is
  /// treated as an existing document id (update via merge). Do not invent client
  /// ids (for example UUIDs) for new rows—those would become the permanent
  /// document ids.
  ///
  /// Remote write uses [SetOptions.merge] per document.
  Future<DataResult<LessonBundle>> saveLessonBundle({
    required Lesson lesson,
    required List<Task> tasks,
    required List<Question> questions,
  });

  /// Delegates to [saveLessonBundle] with empty tasks and questions.
  Future<DataResult<Lesson>> saveCompleteLesson(Lesson lesson);

  /// Deletes lesson with all linked tasks/questions.
  Future<DataResult<void>> deleteLessonCascade(String lessonId);

  /// Persists `sortOrder` as 0..n-1 for the given lesson ids (same course).
  Future<DataResult<void>> updateLessonsSortOrder({
    required String courseId,
    required List<String> lessonIdsOrdered,
  });
}
