// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_remote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskRemote _$TaskRemoteFromJson(Map<String, dynamic> json) => TaskRemote(
  id: json['id'] as String,
  lessonId: json['lessonId'] as String,
  title: json['title'] as String,
  mediaUrl: json['mediaUrl'] as String,
  description: json['description'] as String,
  answer: TaskAnswerRemote.fromJson(json['answer'] as Map<String, dynamic>),
  listImages: (json['listImages'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$TaskRemoteToJson(TaskRemote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lessonId': instance.lessonId,
      'title': instance.title,
      'mediaUrl': instance.mediaUrl,
      'description': instance.description,
      'answer': instance.answer.toJson(),
      'listImages': instance.listImages,
    };
