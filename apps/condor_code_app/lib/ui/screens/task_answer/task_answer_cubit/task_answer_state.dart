import 'package:domain/domain.dart';

sealed class TaskAnswerState {
  const TaskAnswerState();
}

final class TaskAnswerLoading extends TaskAnswerState {
  const TaskAnswerLoading();
}

final class TaskAnswerLoaded extends TaskAnswerState {
  final Answer answer;

  const TaskAnswerLoaded(this.answer);
}
