import 'package:domain/data_result/data_result.dart';
import 'package:domain/models/course.dart';
import 'package:domain/models/lesson.dart';
import 'package:domain/models/question.dart';
import 'package:domain/models/task.dart';

abstract class CoursesRepository {
  Future<DataResult<List<Course>>> fetchAllCourses();

  Future<DataResult<Course>> uploadFullCourseBundle({
    required Course course,
    required List<Lesson> lessons,
    required List<Task> tasks,
    required List<Question> questions,
  });

  Future<DataResult<void>> updateCourseDetails({
    required String courseId,
    required String name,
    required String imageUrl,
  });

  /// Deletes course with all linked lessons/tasks/questions.
  Future<DataResult<void>> deleteCourseCascade(String courseId);
}
