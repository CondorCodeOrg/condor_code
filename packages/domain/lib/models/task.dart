import 'package:domain/models/answer.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final String mediaUrl;
  final String lessonId;
  final Answer answer;
  final List<String> listImages;

  Task({
    required this.id,
    required this.mediaUrl,
    required this.lessonId,
    required this.answer,
    required this.listImages,
    required this.title,
    required this.description,
  });

  Task copyWith({
    String? title,
    String? description,
    String? mediaUrl,
    String? id,
    String? lessonId,
    Answer? answer,
    List<String>? listImages,
  }) {
    return Task(
      mediaUrl: mediaUrl ?? this.mediaUrl,
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      answer: answer ?? this.answer,
      listImages: listImages ?? this.listImages,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
