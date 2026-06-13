import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/screens/tasks_list/tasks_list_cubit/tasks_list_state.dart';
import 'package:domain/domain.dart';

class TasksListCubit extends BaseCubit<TasksListState> {
  TasksListCubit({
    required String lessonId,
    required TasksRepository tasksRepository,
    required super.snackBarEventsProvider,
  }) : _lessonId = lessonId,
       _tasksRepository = tasksRepository,
       super(const TasksListLoading()) {
    _init();
  }

  final TasksRepository _tasksRepository;
  final String _lessonId;

  Future<void> _init() async {
    emit(const TasksListLoading());
    await processDataResult(
      _getTasks(),
      onSuccess: (tasks) {
        emit(TasksListLoaded(tasks));
      },
    );
  }

  Future<DataResult<List<TaskItem>>> _getTasks() =>
      _tasksRepository.getTasks(_lessonId);
}
