import 'package:data/data_sources/remote/feedback_remote_data_source.dart';
import 'package:domain/models/feedback_model.dart';
import 'package:domain/repository/feedback_repository.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  final FeedbackRemoteDataSource _dataSource;

  FeedbackRepositoryImpl(this._dataSource);

  @override
  Future<bool> submitFeedback(FeedbackModel feedback) async {
    try {
      final id = await _dataSource.saveFeedback(feedback);
      return id.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
