import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/models/feedback_model.dart';
import 'package:domain/repository/feedback_repository.dart';
import 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit(this._repo) : super(const FeedbackState());

  final FeedbackRepository _repo;

  Future<void> submitFeedback(FeedbackModel feedback) async {
    emit(state.copyWith(isSubmitting: true, error: null, success: false));

    try {
      final success = await _repo.submitFeedback(feedback);

      emit(
        state.copyWith(
          isSubmitting: false,
          success: success,
          error: success ? null : 'Failed to submit feedback',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          success: false,
          error: e.toString(),
        ),
      );
    }
  }
}
