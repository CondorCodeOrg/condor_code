import 'package:domain/data_result/data_result.dart';
import 'package:domain/models/task.dart';
import 'package:domain/models/task_item.dart';

abstract class TasksRepository {
  Future<DataResult<List<TaskItem>>> getTasks(String lessonId);

  Future<DataResult<Task>> getTask(String taskId);
}
