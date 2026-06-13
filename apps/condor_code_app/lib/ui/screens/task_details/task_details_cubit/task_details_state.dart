import 'package:domain/domain.dart';

sealed class TaskDetailsState {
  const TaskDetailsState();
}

final class TaskDetailsLoading extends TaskDetailsState {
  const TaskDetailsLoading();
}

final class TaskDetailsLoaded extends TaskDetailsState {
  final Task task;

  const TaskDetailsLoaded(this.task);
}
