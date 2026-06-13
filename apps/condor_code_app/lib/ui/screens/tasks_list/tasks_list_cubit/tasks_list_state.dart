import 'package:domain/domain.dart';

sealed class TasksListState {
  const TasksListState();
}

final class TasksListLoading extends TasksListState {
  const TasksListLoading();
}

final class TasksListLoaded extends TasksListState {
  final List<TaskItem> tasks;

  const TasksListLoaded(this.tasks);
}
