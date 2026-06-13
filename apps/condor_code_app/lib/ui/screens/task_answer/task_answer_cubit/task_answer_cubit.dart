import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/screens/task_answer/task_answer_cubit/task_answer_state.dart';
import 'package:domain/domain.dart';

class TaskAnswerCubit extends BaseCubit<TaskAnswerState> {
  TaskAnswerCubit({
    required Answer answer,
    required super.snackBarEventsProvider,
  }) : _answer = answer,
       super(const TaskAnswerLoading()) {
    _init();
  }

  final Answer _answer;

  Future<void> _init() async {
    emit(TaskAnswerLoaded(_answer));
  }
}
