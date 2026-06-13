import 'package:domain/domain.dart';

sealed class LessonDetailsState {
  const LessonDetailsState();
}

final class LessonDetailsLoading extends LessonDetailsState {
  const LessonDetailsLoading();
}

final class LessonDetailsLoaded extends LessonDetailsState {
  final Lesson lesson;
  final bool isTasksExists;

  const LessonDetailsLoaded(this.lesson, {required this.isTasksExists});
}
