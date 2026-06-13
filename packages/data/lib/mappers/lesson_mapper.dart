import 'package:data/data_sources/remote/models/lesson_remote.dart';
import 'package:domain/models/lesson.dart';

extension LessonMapper on Lesson {
  LessonRemote toRemote() {
    return LessonRemote(
      id: id,
      topic: topic,
      youtubeUrl: youtubeUrl,
      title: title,
      description: description,
      isYouTubeLesson: isYouTubeLesson,
      courseId: courseId,
      sortOrder: sortOrder,
    );
  }
}

extension LessonRemoteMapper on LessonRemote {
  Lesson toDomain() {
    return Lesson(
      id: id,
      title: title,
      topic: topic,
      description: description,
      youtubeUrl: youtubeUrl,
      isYouTubeLesson: isYouTubeLesson,
      courseId: courseId,
      sortOrder: sortOrder,
    );
  }
}
