import 'package:json_annotation/json_annotation.dart';

part 'lesson_remote.g.dart';

@JsonSerializable()
class LessonRemote {
  final String id;
  final String courseId;
  final String title;
  final String topic;
  final String description;
  final String youtubeUrl;
  final bool isYouTubeLesson;
  @JsonKey(defaultValue: 0)
  final int sortOrder;
  final String? summary;

  LessonRemote({
    required this.id,
    required this.courseId,
    required this.topic,
    required this.youtubeUrl,
    required this.title,
    required this.description,
    required this.isYouTubeLesson,
    this.sortOrder = 0,
    this.summary,
  });

  LessonRemote copyWith({
    String? id,
    String? title,
    String? topic,
    String? youtubeUrl,
    String? description,
    String? courseId,
    bool? isYouTubeLesson,
    int? sortOrder,
    String? summary,
  }) {
    return LessonRemote(
      id: id ?? this.id,
      title: title ?? this.title,
      topic: topic ?? this.topic,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      description: description ?? this.description,
      courseId: courseId ?? this.courseId,
      isYouTubeLesson: isYouTubeLesson ?? this.isYouTubeLesson,
      sortOrder: sortOrder ?? this.sortOrder,
      summary: summary ?? this.summary,
    );
  }

  factory LessonRemote.fromJson(Map<String, dynamic> json) =>
      _$LessonRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$LessonRemoteToJson(this);
}
