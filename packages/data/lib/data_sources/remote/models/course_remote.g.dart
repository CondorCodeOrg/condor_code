// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_remote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseRemote _$CourseRemoteFromJson(Map<String, dynamic> json) => CourseRemote(
  id: json['id'] as String,
  name: json['name'] as String,
  imageUrl: json['imageUrl'] as String,
  lessonsAmount: (json['lessonsAmount'] as num).toInt(),
);

Map<String, dynamic> _$CourseRemoteToJson(CourseRemote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'lessonsAmount': instance.lessonsAmount,
    };
