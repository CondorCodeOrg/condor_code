class FeedbackState {
  final bool isSubmitting;
  final bool success;
  final String? error;

  const FeedbackState({
    this.isSubmitting = false,
    this.success = false,
    this.error,
  });

  FeedbackState copyWith({bool? isSubmitting, bool? success, String? error}) {
    return FeedbackState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }
}
