import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/screens/test_selection/test_selection_state.dart';
import 'package:domain/domain.dart';

class TestSelectionCubit extends BaseCubit<TestSelectionState> {
  final QuestionRepository questionRepository;
  final LessonsRepository lessonsRepository;
  final String lessonId;

  TestSelectionCubit({
    required this.questionRepository,
    required this.lessonsRepository,
    required super.snackBarEventsProvider,
    required this.lessonId,
  }) : super(const TestSelectionLoading()) {
    loadTests();
  }

  Future<void> loadTests() async {
    emit(const TestSelectionLoading());
    final questionsResult = await questionRepository.getQuestions(lessonId);
    final lessonResult = await lessonsRepository.getLesson(lessonId);

    if (questionsResult is SuccessResult<List<Question>> &&
        lessonResult is SuccessResult<Lesson>) {
      final questions = questionsResult.data ?? [];
      final lesson = lessonResult.data;

      if (lesson == null) {
        emit(const TestSelectionError(message: 'Lesson data is empty.'));
        return;
      }

      if (questions.isEmpty) {
        emit(
          const TestSelectionError(
            message: 'No questions available for this test.',
          ),
        );
        return;
      }

      final test = TestModel(
        id: lessonId,
        title: '${lesson.title} Practice Test',
        difficulty: 'Medium',
        durationMinutes: (questions.length * 1.5).ceil(),
        questionCount: questions.length,
        status: 'Ready',
      );

      emit(TestSelectionLoaded(tests: [test], lessonName: lesson.title));
    } else {
      String errMsg = 'Failed to load test details.';
      if (questionsResult is ErrorResult) {
        errMsg = (questionsResult as ErrorResult).message;
      } else if (lessonResult is ErrorResult) {
        errMsg = (lessonResult as ErrorResult).message;
      }
      emit(TestSelectionError(message: errMsg));
    }
  }

  void selectTest(String testId) {
    final currentState = state;
    if (currentState is TestSelectionLoaded) {
      emit(currentState.copyWith(selectedTestId: testId));
    }
  }
}
