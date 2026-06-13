import 'package:data/data_sources/remote/manager/remote_data_manager.dart';
import 'package:data/mappers/task_mapper.dart';
import 'package:domain/domain.dart';

class TasksRepositoryImpl implements TasksRepository {
  TasksRepositoryImpl({required this.remoteDataManager});

  final RemoteDataManager remoteDataManager;

  @override
  Future<DataResult<List<TaskItem>>> getTasks(String lessonId) => safeDataCall(
    dataCall: () async {
      final remotes = await remoteDataManager.fetchTasksForLesson(lessonId);
      return remotes
          .map(
            (r) => TaskItem(
              id: r.id,
              name: r.title,
              imageUrl: r.listImages.isNotEmpty ? r.listImages.first : '',
            ),
          )
          .toList();
    },
    processResult: SuccessResult.new,
  );

  @override
  Future<DataResult<Task>> getTask(String taskId) => safeDataCall(
    dataCall: () async {
      final remote = await remoteDataManager.fetchTask(taskId);
      return remote.toDomain();
    },
    processResult: SuccessResult.new,
  );
}
