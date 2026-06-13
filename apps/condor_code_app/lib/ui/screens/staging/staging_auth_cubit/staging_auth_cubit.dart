import 'dart:async';

import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/analytics_constants.dart';
import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/screens/staging/staging_auth_cubit/staging_auth_state.dart';
import 'package:condor_code/ui/utils/localization.dart';
import 'package:data/data_sources/shared_pref/shared_preferences_manager.dart';
import 'package:domain/domain.dart';

class StagingAuthCubit extends BaseCubit<StagingAuthState> {
  StagingAuthCubit({
    required AuthRepository authRepository,
    required SharedPreferencesManager sharedPreferencesManager,
    required Analytics analytics,
    required super.snackBarEventsProvider,
  }) : _authRepository = authRepository,
       _sharedPreferencesManager = sharedPreferencesManager,
       _analytics = analytics,
       super(const StagingAuthState()) {
    _tryAutoSignIn();
    _listenToAuthChanges();
  }

  final AuthRepository _authRepository;
  final SharedPreferencesManager _sharedPreferencesManager;
  final Analytics _analytics;
  StreamSubscription<User?>? _authSubscription;

  void _listenToAuthChanges() {
    _authSubscription = _authRepository.authStateChanges.listen((user) {
      emit(state.copyWith(user: user));
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

  Future<void> _tryAutoSignIn() async {
    final credentials = await _sharedPreferencesManager.getStagingCredentials();
    if (credentials == null) return;
    await signInWithEmail(credentials['email']!, credentials['password']!);
  }

  Future<void> signInWithEmail(String email, String password) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty || password.isEmpty) {
      showErrorSnackBar(localization.stagingSignInMissingCredentials);
      return;
    }

    emit(state.copyWith(isSubmitting: true));
    final result = await _authRepository.signInWithEmailPassword(
      email: trimmed,
      password: password,
    );

    emit(state.copyWith(isSubmitting: false));

    result.fold(
      onSuccess: (_) {
        _sharedPreferencesManager.saveStagingCredentials(
          email: trimmed,
          password: password,
        );
      },
      onError: (e) => showErrorSnackBar(_signInErrorMessage(e.message)),
    );
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showErrorSnackBar(localization.stagingSignInMissingCredentials);
      return;
    }
    if (password != confirmPassword) {
      showErrorSnackBar(localization.stagingSignUpPasswordsMismatch);
      return;
    }

    emit(state.copyWith(isSubmitting: true));
    final result = await _authRepository.signUpWithEmailPassword(
      email: trimmed,
      password: password,
      username: '',
      confirmPassword: confirmPassword,
    );

    emit(state.copyWith(isSubmitting: false));

    result.fold(
      onSuccess: (_) {
        _sharedPreferencesManager.saveStagingCredentials(
          email: trimmed,
          password: password,
        );
      },
      onError: (e) => showErrorSnackBar(_signUpErrorMessage(e.message)),
    );
  }

  Future<void> logout() async {
    await _sharedPreferencesManager.clearStagingCredentials();
    await _authRepository.logout();
    _analytics.logEvent(AnalyticsEventName.userLogout, {});
  }

  String _signInErrorMessage(String raw) {
    final lower = raw.toLowerCase();
    if (lower.contains('user-not-found')) {
      return localization.stagingSignInErrorAccountNotFound;
    }
    if (lower.contains('wrong-password') ||
        lower.contains('invalid-credential') ||
        lower.contains('invalid-login-credentials')) {
      return localization.stagingSignInErrorWrongCredentials;
    }
    if (lower.contains('invalid-email')) {
      return localization.stagingSignInErrorInvalidEmail;
    }
    if (lower.contains('user-disabled')) {
      return localization.stagingSignInErrorUserDisabled;
    }
    return localization.stagingSignInErrorGeneric;
  }

  String _signUpErrorMessage(String raw) {
    final lower = raw.toLowerCase();
    if (lower.contains('passwords do not match')) {
      return localization.stagingSignUpPasswordsMismatch;
    }
    if (lower.contains('email-already-in-use')) {
      return localization.stagingSignUpErrorEmailInUse;
    }
    if (lower.contains('weak-password')) {
      return localization.stagingSignUpErrorWeakPassword;
    }
    if (lower.contains('invalid-email')) {
      return localization.stagingSignInErrorInvalidEmail;
    }
    return localization.stagingSignUpErrorGeneric;
  }
}
