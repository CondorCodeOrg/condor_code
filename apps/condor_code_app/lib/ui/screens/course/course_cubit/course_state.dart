import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_state.freezed.dart';

@freezed
abstract class CourseState with _$CourseState {
  const factory CourseState({
    @Default([]) List<LessonItem> lessons,
    Lesson? selectedLesson,
    @Default(false) bool isTasksExist,
    @Default(false) bool isLessonsLoading,
    @Default(false) bool isLessonDetailsLoading,
  }) = _CourseState;
}
