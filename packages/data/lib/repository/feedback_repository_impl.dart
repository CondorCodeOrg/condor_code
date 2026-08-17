import 'package:data/data_sources/remote/manager/remote_data_manager.dart';
import 'package:domain/data_result/data_result.dart';
import 'package:domain/data_result/safe_data_call.dart';
import 'package:domain/models/feedback_model.dart';
import 'package:domain/repository/feedback_repository.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  final RemoteDataManager remoteDataManager;

  FeedbackRepositoryImpl(this.remoteDataManager);

  @override
  Future<DataResult<bool>> submitFeedback(FeedbackModel feedback) async {
    return await safeDataCall(
      dataCall: () async {
        final id = await remoteDataManager.saveFeedback(feedback);
        return id.isNotEmpty;
      },
      processResult: SuccessResult.new,
    );
  }
}
