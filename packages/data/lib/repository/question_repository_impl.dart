import 'package:data/data_sources/remote/manager/remote_data_manager.dart';
import 'package:data/mappers/question_mapper.dart';
import 'package:domain/domain.dart';

class QuestionsRepositoryImpl extends QuestionRepository {
  final RemoteDataManager remoteDataManager;

  QuestionsRepositoryImpl({required this.remoteDataManager});

  @override
  Future<DataResult<List<Question>>> getQuestions(String lessonId) async =>
      safeDataCall(
        dataCall: () async {
          final remotes = await remoteDataManager.fetchQuestionsForLesson(
            lessonId,
          );
          return remotes.map((r) => r.toDomain()).toList();
        },
        processResult: SuccessResult.new,
      );
}
