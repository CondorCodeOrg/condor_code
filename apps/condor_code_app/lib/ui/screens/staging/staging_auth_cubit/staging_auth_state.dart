import 'package:domain/domain.dart';

class StagingAuthState {
  const StagingAuthState({
    this.isSubmitting = false,
    this.isSignUpMode = false,
    this.user,
  });

  final bool isSubmitting;
  final bool isSignUpMode;
  final User? user;

  StagingAuthState copyWith({
    bool? isSubmitting,
    bool? isSignUpMode,
    User? user,
  }) {
    return StagingAuthState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSignUpMode: isSignUpMode ?? this.isSignUpMode,
      user: user ?? this.user,
    );
  }
}
