import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/screens/feedback/feedback_state.dart';
import 'package:domain/models/feedback_model.dart';
import 'package:domain/repository/feedback_repository.dart';

class FeedbackCubit extends BaseCubit<FeedbackState> {
  FeedbackCubit(
      this._repo, {
        required super.snackBarEventsProvider,
      }) : super(const FeedbackState());

  final FeedbackRepository _repo;

  Future<void> submitFeedback(FeedbackModel feedback) async {
    emit(state.copyWith(
      isSubmitting: true,
      error: null,
      success: false,
    ));

    await processDataResult(
      _repo.submitFeedback(feedback),
      onSuccess: (success) {
        emit(
          state.copyWith(
            isSubmitting: false,
            success: success,
          ),
        );
      },
      onError: (_) {
        emit(
          state.copyWith(
            isSubmitting: false,
            success: false,
          ),
        );
      },
    );
  }
}