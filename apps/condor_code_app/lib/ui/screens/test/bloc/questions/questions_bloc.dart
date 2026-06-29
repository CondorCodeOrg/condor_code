import 'package:condor_code/ui/base/bloc/base_bloc.dart';
import 'package:condor_code/ui/screens/test/bloc/questions/questions_event.dart';
import 'package:condor_code/ui/screens/test/bloc/questions/questions_state.dart';
import 'package:condor_code/ui/screens/test/provider/test_screen_events_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/analytics_constants.dart';

class QuestionsBloc extends BaseBloc<QuestionsEvent, QuestionsState> {
  final TestScreenEventsProvider testScreenEventsProvider;
  final QuestionRepository questionRepository;
  final Analytics analytics;
  final String testId;

  QuestionsBloc({
    required this.questionRepository,
    required this.testScreenEventsProvider,
    required this.analytics,
    required this.testId,
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
      questionRepository.getQuestions(testId),
      onSuccess: (questions) {
        if (questions.isEmpty) {
          testScreenEventsProvider.addEvent(TestScreenAction.failedToLoad);
        }
        testScreenEventsProvider.addEvent(TestScreenAction.loaded);
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

    final isCorrect = state.answerNumber == question.rightAnswerNumber;
    analytics.logEvent(AnalyticsEventName.questionAnswered, {
      AnalyticsPropertyName.testId: testId,
      'question_id': question.id,
      'is_correct': isCorrect,
    });

    if (isCorrect) {
      correctCounter++;
      testScreenEventsProvider.addEvent(TestScreenAction.rightAnswer);
    } else {
      incorrectCounter++;
      heartCount--;
      if (heartCount == 0) {
        testScreenEventsProvider.addEvent(TestScreenAction.loseHearts);
      } else {
        incorrectQuestions.add(question);
        testScreenEventsProvider.addEvent(TestScreenAction.wrongAnswer);
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
        testScreenEventsProvider.addEvent(TestScreenAction.finish);
      } else {
        incorrectQuestions = [];

        if (!state.isWorkOnMistakesActive) {
          testScreenEventsProvider.addEvent(TestScreenAction.workOnMistakes);
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
      testScreenEventsProvider.addEvent(TestScreenAction.move);
    }
  }
}
