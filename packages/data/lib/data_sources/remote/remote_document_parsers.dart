import 'package:data/data_sources/remote/models/lesson_remote.dart';
import 'package:data/data_sources/remote/models/question_remote.dart';
import 'package:data/data_sources/remote/models/task_answer_remote.dart';
import 'package:data/data_sources/remote/models/task_remote.dart';

/// Tolerant parsing of Firestore payloads (null / wrong types) into Remote DTOs.
/// Mirrors the approach used when loading [CourseRemote] from loose JSON.
abstract final class RemoteDocumentParsers {
  static LessonRemote lessonFromFirestoreData(
    Map<String, dynamic> data,
    String docId,
  ) {
    return LessonRemote(
      id: docId,
      courseId: _string(data['courseId']),
      youtubeUrl: _string(data['youtubeUrl']),
      isYouTubeLesson: data['isYouTubeLesson'] == true,
      title: _string(data['title']),
      topic: _string(data['topic']),
      description: _string(data['description']),
      sortOrder: _sortOrder(data['sortOrder']),
    );
  }

  static int _sortOrder(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return 0;
  }

  static TaskRemote taskFromFirestoreData(
    Map<String, dynamic> data,
    String docId,
  ) {
    return TaskRemote(
      id: docId,
      lessonId: _string(data['lessonId']),
      title: _string(data['title']),
      mediaUrl: _string(data['mediaUrl']),
      description: _string(data['description']),
      answer: _taskAnswerFromDynamic(data['answer']),
      listImages: _stringList(data['listImages']),
    );
  }

  static QuestionRemote questionFromFirestoreData(
    Map<String, dynamic> data,
    String docId,
  ) {
    return QuestionRemote(
      id: docId,
      lessonId: _string(data['lessonId']),
      title: _string(data['title']),
      description: _string(data['description']),
      firstAnswer: _string(data['firstAnswer']),
      secondAnswer: _string(data['secondAnswer']),
      thirdAnswer: _string(data['thirdAnswer']),
      rightAnswerNumber: _positiveInt(data['rightAnswerNumber'], fallback: 1),
      imageUrl: _nullableString(data['imageUrl']),
    );
  }

  static TaskAnswerRemote _taskAnswerFromDynamic(dynamic value) {
    if (value is! Map) {
      return TaskAnswerRemote(
        title: '',
        mediaUrl: '',
        description: '',
        listImages: const [],
      );
    }
    final m = Map<String, dynamic>.from(value);
    return TaskAnswerRemote(
      title: _string(m['title']),
      mediaUrl: _string(m['mediaUrl']),
      description: _string(m['description']),
      listImages: _stringList(m['listImages']),
    );
  }

  static String _string(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  static String? _nullableString(dynamic value) {
    if (value == null) return null;
    final s = value.toString();
    return s.isEmpty ? null : s;
  }

  static List<String> _stringList(dynamic value) {
    if (value is! List) return const [];
    return value.map((e) => e?.toString() ?? '').toList();
  }

  static int _positiveInt(dynamic value, {required int fallback}) {
    if (value is int) return value < 1 ? fallback : value;
    if (value is num) {
      final n = value.toInt();
      return n < 1 ? fallback : n;
    }
    return fallback;
  }
}
