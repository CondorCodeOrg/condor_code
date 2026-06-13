import 'package:data/data_sources/remote/models/lesson_remote.dart';
import 'package:data/data_sources/remote/models/question_remote.dart';
import 'package:data/data_sources/remote/models/task_remote.dart';

/// Result of [RemoteDataManager.saveLessonBundle]: every [LessonRemote], [TaskRemote],
/// and [QuestionRemote] carries the Firestore document id after the write (empty
/// input ids are replaced by the allocated ids).
class LessonBundleRemote {
  const LessonBundleRemote({
    required this.lesson,
    required this.tasks,
    required this.questions,
  });

  final LessonRemote lesson;
  final List<TaskRemote> tasks;
  final List<QuestionRemote> questions;
}
