// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_remote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonRemote _$LessonRemoteFromJson(Map<String, dynamic> json) => LessonRemote(
  id: json['id'] as String,
  courseId: json['courseId'] as String,
  topic: json['topic'] as String,
  youtubeUrl: json['youtubeUrl'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  isYouTubeLesson: json['isYouTubeLesson'] as bool,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$LessonRemoteToJson(LessonRemote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'title': instance.title,
      'topic': instance.topic,
      'description': instance.description,
      'youtubeUrl': instance.youtubeUrl,
      'isYouTubeLesson': instance.isYouTubeLesson,
      'sortOrder': instance.sortOrder,
    };
