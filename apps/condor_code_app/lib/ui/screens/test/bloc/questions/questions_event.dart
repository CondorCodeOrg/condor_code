sealed class QuestionsEvent {}

class OnLoadQuestionsEvent extends QuestionsEvent {}

class OnAnswerSelectedEvent extends QuestionsEvent {
  final int answerNumber;

  OnAnswerSelectedEvent({required this.answerNumber});
}

class OnMoveOnButtonPressedEvent extends QuestionsEvent {}

class OnConfirmQuestionEvent extends QuestionsEvent {}
