import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'questions_state.freezed.dart';

@freezed
abstract class QuestionsState with _$QuestionsState {
  const factory QuestionsState({
    @Default(0) int correctCounter,
    @Default(0) int incorrectCounter,
    @Default([]) List<Question> questions,
    @Default([]) List<Question> incorrectQuestions,
    @Default(0) int currentQuestionPosition,
    @Default(0) int answerNumber,
    @Default(5) int heartCounter,
    @Default(false) bool isWorkOnMistakesActive,
    @Default(false) bool isButtonEnabled,
  }) = _QuestionsState;

  const QuestionsState._();

  double get completePercentage =>
      questions.isEmpty ? 0 : 1 / questions.length * currentQuestionPosition;

  bool get isLastQuestion => currentQuestionPosition >= questions.length - 1;

  Question get currentQuestion => questions[currentQuestionPosition];
}
