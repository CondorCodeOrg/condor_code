class Question {
  final String id;
  final String lessonId;
  final String title;
  final String description;
  final String firstAnswer;
  final String secondAnswer;
  final String thirdAnswer;
  final int rightAnswerNumber;
  final String? imageUrl;

  Question({
    required this.id,
    required this.lessonId,
    this.imageUrl,
    required this.rightAnswerNumber,
    required this.title,
    required this.description,
    required this.firstAnswer,
    required this.secondAnswer,
    required this.thirdAnswer,
  });

  Question copyWith({
    String? id,
    String? lessonId,
    String? imageUrl,
    int? rightAnswerNumber,
    String? title,
    String? description,
    String? firstAnswer,
    String? secondAnswer,
    String? thirdAnswer,
  }) {
    return Question(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      imageUrl: imageUrl ?? this.imageUrl,
      rightAnswerNumber: rightAnswerNumber ?? this.rightAnswerNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      firstAnswer: firstAnswer ?? this.firstAnswer,
      secondAnswer: secondAnswer ?? this.secondAnswer,
      thirdAnswer: thirdAnswer ?? this.thirdAnswer,
    );
  }
}
