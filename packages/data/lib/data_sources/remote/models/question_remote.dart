import 'package:json_annotation/json_annotation.dart';

part 'question_remote.g.dart';

@JsonSerializable()
class QuestionRemote {
  final String id;
  final String lessonId;
  final String title;
  final String description;
  final String firstAnswer;
  final String secondAnswer;
  final String thirdAnswer;
  final int rightAnswerNumber;
  final String? imageUrl;

  QuestionRemote({
    required this.id,
    required this.lessonId,
    required this.title,
    required this.description,
    required this.firstAnswer,
    required this.secondAnswer,
    required this.thirdAnswer,
    required this.rightAnswerNumber,
    this.imageUrl,
  });

  QuestionRemote copyWith({
    String? id,
    String? lessonId,
    String? title,
    String? description,
    String? firstAnswer,
    String? secondAnswer,
    String? thirdAnswer,
    int? rightAnswerNumber,
    String? imageUrl,
  }) {
    return QuestionRemote(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      title: title ?? this.title,
      description: description ?? this.description,
      firstAnswer: firstAnswer ?? this.firstAnswer,
      secondAnswer: secondAnswer ?? this.secondAnswer,
      thirdAnswer: thirdAnswer ?? this.thirdAnswer,
      rightAnswerNumber: rightAnswerNumber ?? this.rightAnswerNumber,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory QuestionRemote.fromJson(Map<String, dynamic> json) =>
      _$QuestionRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionRemoteToJson(this);
}
