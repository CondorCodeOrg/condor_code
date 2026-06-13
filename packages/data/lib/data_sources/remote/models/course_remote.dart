import 'package:json_annotation/json_annotation.dart';

part 'course_remote.g.dart';

@JsonSerializable()
class CourseRemote {
  final String id;
  final String name;
  final String imageUrl;
  final int lessonsAmount;

  CourseRemote({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.lessonsAmount,
  });

  CourseRemote copyWith({
    String? id,
    String? name,
    String? imageUrl,
    int? lessonsAmount,
  }) {
    return CourseRemote(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      lessonsAmount: lessonsAmount ?? this.lessonsAmount,
    );
  }

  factory CourseRemote.fromJson(Map<String, dynamic> json) =>
      _$CourseRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$CourseRemoteToJson(this);
}
