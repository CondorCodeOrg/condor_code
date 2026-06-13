import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'courses_state.freezed.dart';

/// One-shot route emitted by [CoursesCubit.openCourse]; UI performs [context.go] then calls [CoursesCubit.consumeOpenCommand].
final class CourseOpenCommand {
  const CourseOpenCommand({
    required this.seq,
    required this.location,
    required this.courseNameExtra,
    this.courseId,
  });

  final int seq;
  final String location;
  final String? courseId;

  /// Passed as GoRouter [extra] (course title for the course screen).
  final String courseNameExtra;
}

@Freezed(toStringOverride: false)
abstract class CoursesState with _$CoursesState {
  const factory CoursesState({
    @Default([]) List<Course> courses,
    @Default(false) bool isLoading,
    CourseOpenCommand? openCommand,
  }) = _CoursesState;
}
