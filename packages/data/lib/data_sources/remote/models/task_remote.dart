import 'package:data/data_sources/remote/models/task_answer_remote.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_remote.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskRemote {
  final String id;
  final String lessonId;
  final String title;
  final String mediaUrl;
  final String description;
  final TaskAnswerRemote answer;
  final List<String> listImages;

  TaskRemote({
    required this.id,
    required this.lessonId,
    required this.title,
    required this.mediaUrl,
    required this.description,
    required this.answer,
    required this.listImages,
  });

  TaskRemote copyWith({
    String? id,
    String? lessonId,
    String? title,
    String? mediaUrl,
    String? description,
    TaskAnswerRemote? answer,
    List<String>? listImages,
  }) {
    return TaskRemote(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      title: title ?? this.title,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      description: description ?? this.description,
      answer: answer ?? this.answer,
      listImages: listImages ?? this.listImages,
    );
  }

  factory TaskRemote.fromJson(Map<String, dynamic> json) =>
      _$TaskRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$TaskRemoteToJson(this);
}
