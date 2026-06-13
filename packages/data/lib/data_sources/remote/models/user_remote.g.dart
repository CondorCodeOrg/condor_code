// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_remote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRemote _$UserRemoteFromJson(Map<String, dynamic> json) => UserRemote(
  id: json['id'] as String,
  fullName: json['fullName'] as String?,
  email: json['email'] as String,
  role: json['role'] as String,
);

Map<String, dynamic> _$UserRemoteToJson(UserRemote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'role': instance.role,
    };
