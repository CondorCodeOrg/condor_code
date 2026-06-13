import 'package:json_annotation/json_annotation.dart';

part 'task_answer_remote.g.dart';

@JsonSerializable()
class TaskAnswerRemote {
  final String title;
  final String mediaUrl;
  final String description;
  final List<String> listImages;

  TaskAnswerRemote({
    required this.title,
    required this.mediaUrl,
    required this.description,
    required this.listImages,
  });

  factory TaskAnswerRemote.fromJson(Map<String, dynamic> json) =>
      _$TaskAnswerRemoteFromJson(json);

  Map<String, dynamic> toJson() => _$TaskAnswerRemoteToJson(this);
}
