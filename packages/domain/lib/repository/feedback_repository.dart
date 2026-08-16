import 'package:domain/data_result/data_result.dart';
import 'package:domain/models/feedback_model.dart';

abstract class FeedbackRepository {
  Future<DataResult<bool>> submitFeedback(FeedbackModel feedback);
}
