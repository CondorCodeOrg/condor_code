import 'package:domain/models/feedback_model.dart';

abstract class FeedbackRepository {
  Future<bool> submitFeedback(FeedbackModel feedback);
}
