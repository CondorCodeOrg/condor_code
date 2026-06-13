import 'package:condor_code/ui/base/bloc/base_bloc.dart';
import 'package:condor_code/ui/screens/lesson/bloc/questions/questions_event.dart';
import 'package:condor_code/ui/screens/lesson/bloc/questions/questions_state.dart';
import 'package:condor_code/ui/screens/lesson/provider/lesson_screen_events_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionsBloc extends BaseBloc<QuestionsEvent, QuestionsState> {
  final LessonScreenEventsProvider lessonScreenEventsProvider;
  final QuestionRepository questionRepository;
  final String lessonId;

  QuestionsBloc({
    required this.questionRepository,
    required this.lessonScreenEventsProvider,
    required this.lessonId,
    required super.snackBarEventsProvider,
  }) : super(const QuestionsState()) {
    on<QuestionsEvent>((event, emit) async {
      switch (event) {
        case OnLoadQuestionsEvent():
          await _onGetQuestions(emit);
        case OnMoveOnButtonPressedEvent():
          _onMoveOn(emit);
          break;
        case OnAnswerSelectedEvent():
          emit(state.copyWith(answerNumber: event.answerNumber));
        case OnConfirmQuestionEvent():
          _onConfirmQuestion(emit);
      }
    });
  }

  Future<void> _onGetQuestions(Emitter<QuestionsState> emit) async {
    await processDataResult(
      questionRepository.getQuestions(lessonId),
      onSuccess: (questions) {
        if (questions.isEmpty) {
          lessonScreenEventsProvider.addEvent(LessonScreenAction.failedToLoad);
        }
        lessonScreenEventsProvider.addEvent(LessonScreenAction.loaded);
        emit(QuestionsState(questions: questions));
      },
    );
  }

  void _onMoveOn(Emitter<QuestionsState> emit) {
    if (state.answerNumber == 0) return;

    final question = state.questions[state.currentQuestionPosition];

    var correctCounter = state.correctCounter;
    var incorrectCounter = state.incorrectCounter;
    var heartCount = state.heartCounter;
    final questions = state.questions;
    final incorrectQuestions = List.of(state.incorrectQuestions);
    final isWorkOnMistakes = state.isWorkOnMistakesActive;

    if (state.answerNumber == question.rightAnswerNumber) {
      correctCounter++;
      lessonScreenEventsProvider.addEvent(LessonScreenAction.rightAnswer);
    } else {
      incorrectCounter++;
      heartCount--;
      if (heartCount == 0) {
        lessonScreenEventsProvider.addEvent(LessonScreenAction.loseHearts);
      } else {
        incorrectQuestions.add(question);
        lessonScreenEventsProvider.addEvent(LessonScreenAction.wrongAnswer);
      }
    }

    emit(
      state.copyWith(
        questions: questions,
        correctCounter: correctCounter,
        incorrectCounter: incorrectCounter,
        heartCounter: heartCount,
        incorrectQuestions: incorrectQuestions,
        isWorkOnMistakesActive: isWorkOnMistakes,
        answerNumber: 0,
      ),
    );
  }

  void _onConfirmQuestion(Emitter<QuestionsState> emit) {
    var currentQuestionPosition = state.currentQuestionPosition;
    var incorrectQuestions = List.of(state.incorrectQuestions);

    if (state.isLastQuestion) {
      if (incorrectQuestions.isEmpty) {
        lessonScreenEventsProvider.addEvent(LessonScreenAction.finish);
      } else {
        incorrectQuestions = [];

        if (!state.isWorkOnMistakesActive) {
          lessonScreenEventsProvider.addEvent(
            LessonScreenAction.workOnMistakes,
          );
        }

        emit(
          state.copyWith(
            questions: state.incorrectQuestions,
            correctCounter: 0,
            incorrectCounter: 0,
            incorrectQuestions: [],
            currentQuestionPosition: 0,
            isWorkOnMistakesActive: true,
          ),
        );
      }
    } else {
      currentQuestionPosition++;
      emit(state.copyWith(currentQuestionPosition: currentQuestionPosition));
      lessonScreenEventsProvider.addEvent(LessonScreenAction.move);
    }
  }
}
