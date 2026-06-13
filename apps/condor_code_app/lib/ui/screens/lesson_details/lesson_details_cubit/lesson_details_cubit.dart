import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/screens/lesson_details/lesson_details_cubit/lesson_details_state.dart';
import 'package:domain/domain.dart';

class LessonDetailsCubit extends BaseCubit<LessonDetailsState> {
  LessonDetailsCubit({
    required String lessonId,
    required LessonsRepository lessonsRepository,
    required TasksRepository tasksRepository,
    required super.snackBarEventsProvider,
  }) : _lessonId = lessonId,
       _lessonsRepository = lessonsRepository,
       _tasksRepository = tasksRepository,
       super(const LessonDetailsLoading()) {
    _init();
  }

  final LessonsRepository _lessonsRepository;
  final TasksRepository _tasksRepository;
  final String _lessonId;

  Future<void> _init() async {
    emit(const LessonDetailsLoading());
    processDataResultCombine2(
      _lessonsRepository.getLesson(_lessonId),
      _tasksRepository.getTasks(_lessonId),
      onSuccess: (Lesson lesson, List<TaskItem> tasks) {
        emit(LessonDetailsLoaded(lesson, isTasksExists: tasks.isNotEmpty));
      },
    );
  }
}
