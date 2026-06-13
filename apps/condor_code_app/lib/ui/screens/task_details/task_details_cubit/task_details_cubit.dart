import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/screens/task_details/task_details_cubit/task_details_state.dart';
import 'package:domain/domain.dart';

class TaskDetailsCubit extends BaseCubit<TaskDetailsState> {
  TaskDetailsCubit({
    required String taskId,
    required TasksRepository tasksRepository,
    required super.snackBarEventsProvider,
  }) : _taskId = taskId,
       _tasksRepository = tasksRepository,
       super(const TaskDetailsLoading()) {
    _init();
  }

  final TasksRepository _tasksRepository;
  final String _taskId;

  Future<void> _init() async {
    emit(const TaskDetailsLoading());
    await processDataResult(
      _getTaskDetails(),
      onSuccess: (task) {
        emit(TaskDetailsLoaded(task));
      },
    );
  }

  Future<DataResult<Task>> _getTaskDetails() =>
      _tasksRepository.getTask(_taskId);
}
