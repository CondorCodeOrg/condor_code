import 'package:data/data_sources/remote/manager/remote_data_manager.dart';
import 'package:data/mappers/course_mapper.dart';
import 'package:data/mappers/lesson_mapper.dart';
import 'package:data/mappers/question_mapper.dart';
import 'package:data/mappers/task_mapper.dart';
import 'package:domain/domain.dart';

class CoursesRepositoryImpl implements CoursesRepository {
  CoursesRepositoryImpl({required this.remoteDataManager});

  final RemoteDataManager remoteDataManager;

  @override
  Future<DataResult<List<Course>>> fetchAllCourses() => safeDataCall(
    dataCall: () async {
      final remotes = await remoteDataManager.fetchAllCourses();
      return remotes.map((r) => r.toDomain()).toList();
    },
    processResult: SuccessResult.new,
  );

  @override
  Future<DataResult<Course>> uploadFullCourseBundle({
    required Course course,
    required List<Lesson> lessons,
    required List<Task> tasks,
    required List<Question> questions,
  }) async {
    return safeDataCall(
      dataCall: () async {
        final saved = await remoteDataManager.uploadFullCourseBundle(
          course: course.toRemote(),
          lessons: lessons.map((lesson) => lesson.toRemote()).toList(),
          tasks: tasks.map((task) => task.toRemote()).toList(),
          questions: questions.map((question) => question.toRemote()).toList(),
        );
        return saved.toDomain();
      },
      processResult: SuccessResult.new,
    );
  }

  @override
  Future<DataResult<void>> updateCourseDetails({
    required String courseId,
    required String name,
    required String imageUrl,
  }) => safeDataCall(
    dataCall: () async {
      await remoteDataManager.updateCourseDetails(
        courseId: courseId,
        name: name,
        imageUrl: imageUrl,
      );
      return null;
    },
    processResult: (_) => SuccessResult<void>(null),
  );

  @override
  Future<DataResult<void>> deleteCourseCascade(String courseId) => safeDataCall(
    dataCall: () async {
      await remoteDataManager.deleteCourseCascade(courseId);
      return null;
    },
    processResult: (_) => SuccessResult<void>(null),
  );
}
