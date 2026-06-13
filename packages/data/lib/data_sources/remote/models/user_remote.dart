import 'package:json_annotation/json_annotation.dart';

part 'user_remote.g.dart';

@JsonSerializable()
class UserRemote {
  final String id;
  final String? fullName;
  final String email;
  final String role;

  UserRemote({
    required this.id,
    this.fullName,
    required this.email,
    required this.role,
  });

  factory UserRemote.fromJson(Map<String, dynamic> json) =>
      _$UserRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$UserRemoteToJson(this);
}
