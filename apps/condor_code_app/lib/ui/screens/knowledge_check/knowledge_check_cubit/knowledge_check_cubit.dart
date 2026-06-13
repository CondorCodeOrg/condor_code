import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/screens/knowledge_check/knowledge_check_cubit/knowledge_check_state.dart';
import 'package:domain/domain.dart';

class KnowledgeCheckCubit extends BaseCubit<KnowledgeCheckState> {
  KnowledgeCheckCubit({
    required String lessonId,
    required TasksRepository tasksRepository,
    required super.snackBarEventsProvider,
    this.initialTaskId,
  }) : _lessonId = lessonId,
       _tasksRepository = tasksRepository,
       super(const KnowledgeCheckState()) {
    _loadTasks();
  }

  final TasksRepository _tasksRepository;
  final String _lessonId;
  final String? initialTaskId;

  Future<void> _loadTasks() async {
    emit(state.copyWith(isTasksLoading: true));
    await processDataResult(
      _tasksRepository.getTasks(_lessonId),
      onSuccess: (tasks) {
        emit(state.copyWith(tasks: tasks, isTasksLoading: false));
        if (tasks.isNotEmpty) {
          final targetId = _resolveInitialTask(tasks);
          selectTask(targetId);
        }
      },
    );
  }

  String _resolveInitialTask(List<TaskItem> tasks) {
    if (initialTaskId != null && initialTaskId != 'first') {
      final match = tasks.where((t) => t.id == initialTaskId);
      if (match.isNotEmpty) return match.first.id;
    }
    return tasks.first.id;
  }

  Future<void> selectTask(String taskId) async {
    emit(state.copyWith(isTaskDetailsLoading: true));
    await processDataResult(
      _tasksRepository.getTask(taskId),
      onSuccess: (task) {
        emit(state.copyWith(selectedTask: task, isTaskDetailsLoading: false));
      },
    );
  }
}
