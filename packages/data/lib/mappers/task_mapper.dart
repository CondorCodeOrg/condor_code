import 'package:data/data_sources/remote/models/task_answer_remote.dart';
import 'package:data/data_sources/remote/models/task_remote.dart';
import 'package:domain/models/answer.dart';
import 'package:domain/models/task.dart';

extension TaskMapper on Task {
  TaskRemote toRemote() {
    return TaskRemote(
      id: id,
      lessonId: lessonId,
      title: title,
      mediaUrl: mediaUrl,
      description: description,
      answer: answer.toRemote(),
      listImages: listImages,
    );
  }
}

extension TaskRemoteMapper on TaskRemote {
  Task toDomain() {
    return Task(
      id: id,
      lessonId: lessonId,
      title: title,
      mediaUrl: mediaUrl,
      description: description,
      answer: answer.toDomain(),
      listImages: listImages,
    );
  }
}

extension AnswerMapper on Answer {
  TaskAnswerRemote toRemote() {
    return TaskAnswerRemote(
      title: title,
      mediaUrl: mediaUrl,
      description: description,
      listImages: listImages,
    );
  }
}

extension TaskAnswerRemoteMapper on TaskAnswerRemote {
  Answer toDomain() {
    return Answer(
      title: title,
      mediaUrl: mediaUrl,
      description: description,
      listImages: listImages,
    );
  }
}
