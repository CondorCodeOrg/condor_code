// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_answer_remote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskAnswerRemote _$TaskAnswerRemoteFromJson(Map<String, dynamic> json) =>
    TaskAnswerRemote(
      title: json['title'] as String,
      mediaUrl: json['mediaUrl'] as String,
      description: json['description'] as String,
      listImages: (json['listImages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TaskAnswerRemoteToJson(TaskAnswerRemote instance) =>
    <String, dynamic>{
      'title': instance.title,
      'mediaUrl': instance.mediaUrl,
      'description': instance.description,
      'listImages': instance.listImages,
    };
