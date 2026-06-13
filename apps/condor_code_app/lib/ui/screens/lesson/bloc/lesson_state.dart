part of 'lesson_cubit.dart';

sealed class LessonState {}

final class LessonLoading extends LessonState {}

final class LessonLoaded extends LessonState {}

final class LessonMoving extends LessonState {}

final class LessonRightAnswer extends LessonState {}

final class LessonWrongAnswer extends LessonState {}

final class LessonWorkOnMistakes extends LessonState {}

final class LessonLoseHearts extends LessonState {}

final class LessonFinished extends LessonState {}

final class LessonLoadFailure extends LessonState {}
