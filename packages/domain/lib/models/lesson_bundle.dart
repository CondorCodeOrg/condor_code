import 'package:domain/models/lesson.dart';
import 'package:domain/models/question.dart';
import 'package:domain/models/task.dart';

/// Lesson plus related tasks and questions after a successful bundle save/load.
///
/// After a bundle save through the lessons repository, ids match the remote
/// documents (new rows that were sent with empty ids come back with allocated ids).
class LessonBundle {
  const LessonBundle({
    required this.lesson,
    required this.tasks,
    required this.questions,
  });

  final Lesson lesson;
  final List<Task> tasks;
  final List<Question> questions;
}
