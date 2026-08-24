import 'dart:async';

import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/analytics_constants.dart';
import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/screens/auth/auth_cubit/auth_state.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:domain/domain.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit({
    required AuthRepository authRepository,
    required Analytics analytics,
    required super.snackBarEventsProvider,
  }) : _authRepository = authRepository,
       _analytics = analytics,
       super(const AuthState()) {
    _listenToAuthChanges();
  }

  final AuthRepository _authRepository;
  final Analytics _analytics;
  StreamSubscription<User?>? _authSubscription;

  void _listenToAuthChanges() {
    _authSubscription = _authRepository.authStateChanges.listen((user) {
      emit(state.copyWith(user: user, clearUser: user == null));
    });
  }

  @override
  Future<void> close() async {
    await _authSubscription?.cancel();
    return super.close();
  }

  void setSignUpMode(bool isSignUpMode) {
    if (state.isSignUpMode == isSignUpMode) return;
    emit(state.copyWith(isSignUpMode: isSignUpMode));
  }

  Future<void> signInWithEmail(String email, String password) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty || password.isEmpty) {
      showErrorSnackBar(localization.signInMissingCredentials);
      return;
    }

    emit(state.copyWith(isSubmitting: true));
    final result = await _authRepository.signInWithEmailPassword(
      email: trimmed,
      password: password,
    );

    emit(state.copyWith(isSubmitting: false));

    result.fold(
      onSuccess: (_) {},
      onError: (e) => showErrorSnackBar(_signInErrorMessage(e.message)),
    );
  }

  Future<void> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final trimmedName = fullName.trim();
    final trimmed = email.trim();
    if (trimmedName.isEmpty ||
        trimmed.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showErrorSnackBar(localization.signUpMissingFields);
      return;
    }
    if (password != confirmPassword) {
      showErrorSnackBar(localization.signUpPasswordsMismatch);
      return;
    }

    emit(state.copyWith(isSubmitting: true));
    final result = await _authRepository.signUpWithEmailPassword(
      email: trimmed,
      password: password,
      username: trimmedName,
      confirmPassword: confirmPassword,
    );

    emit(state.copyWith(isSubmitting: false));

    result.fold(
      onSuccess: (_) {},
      onError: (e) => showErrorSnackBar(_signUpErrorMessage(e.message)),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(isSubmitting: true));
    final result = await _authRepository.signInWithGoogle();
    emit(state.copyWith(isSubmitting: false));

    result.fold(
      onSuccess: (_) {},
      onError: (e) {
        final lower = e.message.toLowerCase();
        if (lower.contains('popup-closed') ||
            lower.contains('cancelled') ||
            lower.contains('canceled')) {
          return;
        }
        showErrorSnackBar(_googleErrorMessage(e.message));
      },
    );
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _analytics.logEvent(AnalyticsEventName.userLogout, {});
  }

  String _signInErrorMessage(String raw) {
    final lower = raw.toLowerCase();
    if (lower.contains('user-not-found')) {
      return localization.signInErrorAccountNotFound;
    }
    if (lower.contains('wrong-password') ||
        lower.contains('invalid-credential') ||
        lower.contains('invalid-login-credentials')) {
      return localization.signInErrorWrongCredentials;
    }
    if (lower.contains('invalid-email')) {
      return localization.signInErrorInvalidEmail;
    }
    if (lower.contains('user-disabled')) {
      return localization.signInErrorUserDisabled;
    }
    return localization.signInErrorGeneric;
  }

  String _signUpErrorMessage(String raw) {
    final lower = raw.toLowerCase();
    if (lower.contains('passwords do not match')) {
      return localization.signUpPasswordsMismatch;
    }
    if (lower.contains('email-already-in-use')) {
      return localization.signUpErrorEmailInUse;
    }
    if (lower.contains('weak-password')) {
      return localization.signUpErrorWeakPassword;
    }
    if (lower.contains('invalid-email')) {
      return localization.signInErrorInvalidEmail;
    }
    return localization.signUpErrorGeneric;
  }

  String _googleErrorMessage(String raw) {
    final lower = raw.toLowerCase();
    if (lower.contains('account-exists-with-different-credential')) {
      return localization.signInWithGoogleAccountExists;
    }
    if (lower.contains('popup-closed') ||
        lower.contains('cancelled') ||
        lower.contains('canceled')) {
      return localization.signInErrorGeneric;
    }
    return localization.signInWithGoogleError;
  }
}
