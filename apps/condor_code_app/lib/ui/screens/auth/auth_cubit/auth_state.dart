import 'package:domain/domain.dart';

class AuthState {
  const AuthState({
    this.isSubmitting = false,
    this.isSignUpMode = false,
    this.user,
  });

  final bool isSubmitting;
  final bool isSignUpMode;
  final User? user;

  AuthState copyWith({
    bool? isSubmitting,
    bool? isSignUpMode,
    User? user,
    bool clearUser = false,
  }) {
    return AuthState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSignUpMode: isSignUpMode ?? this.isSignUpMode,
      user: clearUser ? null : (user ?? this.user),
    );
  }
}
