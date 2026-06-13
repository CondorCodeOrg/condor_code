import 'package:domain/domain.dart';

class KnowledgeCheckState {
  const KnowledgeCheckState({
    this.tasks = const [],
    this.selectedTask,
    this.isTasksLoading = false,
    this.isTaskDetailsLoading = false,
  });

  final List<TaskItem> tasks;
  final Task? selectedTask;
  final bool isTasksLoading;
  final bool isTaskDetailsLoading;

  KnowledgeCheckState copyWith({
    List<TaskItem>? tasks,
    Task? selectedTask,
    bool? isTasksLoading,
    bool? isTaskDetailsLoading,
  }) {
    return KnowledgeCheckState(
      tasks: tasks ?? this.tasks,
      selectedTask: selectedTask ?? this.selectedTask,
      isTasksLoading: isTasksLoading ?? this.isTasksLoading,
      isTaskDetailsLoading: isTaskDetailsLoading ?? this.isTaskDetailsLoading,
    );
  }
}
