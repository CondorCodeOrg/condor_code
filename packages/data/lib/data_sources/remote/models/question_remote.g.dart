// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_remote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionRemote _$QuestionRemoteFromJson(Map<String, dynamic> json) =>
    QuestionRemote(
      id: json['id'] as String,
      lessonId: json['lessonId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      firstAnswer: json['firstAnswer'] as String,
      secondAnswer: json['secondAnswer'] as String,
      thirdAnswer: json['thirdAnswer'] as String,
      rightAnswerNumber: (json['rightAnswerNumber'] as num).toInt(),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$QuestionRemoteToJson(QuestionRemote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lessonId': instance.lessonId,
      'title': instance.title,
      'description': instance.description,
      'firstAnswer': instance.firstAnswer,
      'secondAnswer': instance.secondAnswer,
      'thirdAnswer': instance.thirdAnswer,
      'rightAnswerNumber': instance.rightAnswerNumber,
      'imageUrl': instance.imageUrl,
    };
