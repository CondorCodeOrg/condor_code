import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/screens/lessons_list/lessons_list_cubit/lessons_list_state.dart';
import 'package:domain/domain.dart';

class LessonsListCubit extends BaseCubit<LessonsListState> {
  LessonsListCubit({
    required String courseId,
    required LessonsRepository lessonsRepository,
    required super.snackBarEventsProvider,
  }) : _courseId = courseId,
       _lessonsRepository = lessonsRepository,
       super(const LessonsListLoading()) {
    _init();
  }

  final LessonsRepository _lessonsRepository;
  final String _courseId;

  Future<void> _init() async {
    emit(const LessonsListLoading());
    await processDataResult(
      _getLessonsCards(),
      onSuccess: (lessons) {
        emit(LessonsListLoaded(lessons));
      },
    );
  }

  Future<DataResult<List<LessonItem>>> _getLessonsCards() =>
      _lessonsRepository.getLessonsItems(_courseId);
}
