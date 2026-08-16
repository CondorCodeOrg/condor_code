class FeedbackState {
  final bool isSubmitting;
  final bool success;

  const FeedbackState({this.isSubmitting = false, this.success = false});

  FeedbackState copyWith({bool? isSubmitting, bool? success}) {
    return FeedbackState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      success: success ?? this.success,
    );
  }
}
