import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:domain/models/feedback_model.dart';
import 'package:domain/repository/feedback_repository.dart';
import 'feedback_state.dart';

class FeedbackCubit extends BaseCubit<FeedbackState> {
  FeedbackCubit(this._repo, {required super.snackBarEventsProvider})
    : super(const FeedbackState());

  final FeedbackRepository _repo;

  Future<void> submitFeedback(FeedbackModel feedback) async {
    await processDataResult(
      operation: () => _repo.submitFeedback(feedback),
      onLoading: () => emit(state.copyWith(isSubmitting: true, error: null)),
      onSuccess: (success) {
        emit(
          state.copyWith(
            isSubmitting: false,
            success: success,
            error: success ? null : 'Failed to submit feedback',
          ),
        );
      },
      onError: (e) {
        emit(
          state.copyWith(
            isSubmitting: false,
            success: false,
            error: e.toString(),
          ),
        );
      },
    );
  }
}
