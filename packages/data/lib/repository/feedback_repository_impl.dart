import 'package:data/data_sources/remote/feedback_remote_data_source.dart';
import 'package:domain/data_result/data_result.dart';
import 'package:domain/data_result/safe_data_call.dart';
import 'package:domain/models/feedback_model.dart';
import 'package:domain/repository/feedback_repository.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  final FeedbackRemoteDataSource _dataSource;

  FeedbackRepositoryImpl(this._dataSource);

  @override
  Future<DataResult<bool>> submitFeedback(FeedbackModel feedback) async {
    return await safeDataCall(
      dataCall: () async {
        final id = await _dataSource.saveFeedback(feedback);
        return id.isNotEmpty;
      },
      processResult: SuccessResult.new,
    );
  }
}