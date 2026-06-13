import 'package:condorcode_admin/presentation/logic/auth/sign_up_notifier/sign_up_state.dart';
import 'package:condorcode_admin/presentation/logic/providers.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ui_kit/ui_kit.dart';

final signUpProvider =
    StateNotifierProvider.autoDispose<SignUpNotifier, SignUpState>(
      (ref) =>
          SignUpNotifier(authRepository: ref.watch(authRepositoryProvider)),
    );

class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier({required this.authRepository}) : super(const SignUpState());

  final AuthRepository authRepository;

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void toggleConfirmedPasswordVisibility() {
    state = state.copyWith(
      isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
    );
  }

  void updateEmail(String email) {
    state = state.copyWith(
      email: email,
      emailError: false,
      commonErrorMessage: null,
    );
  }

  void updateUsername(String username) {
    state = state.copyWith(
      username: username,
      usernameError: false,
      commonErrorMessage: null,
    );
  }

  void updatePassword(String password) {
    state = state.copyWith(
      password: password,
      passwordError: false,
      commonErrorMessage: null,
    );
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(
      confirmPassword: confirmPassword,
      confirmPasswordError: false,
      commonErrorMessage: null,
    );
  }

  Future<void> signUp() async {
    if (!_validate()) return;

    state = state.copyWith(isProcessing: true, commonErrorMessage: null);

    final result = await authRepository.signUpWithEmailPassword(
      email: state.email,
      password: state.password,
      username: state.username,
      confirmPassword: state.confirmPassword,
    );

    result.fold(
      onSuccess: (_) async {},
      onError: (error) {
        state = state.copyWith(commonErrorMessage: {'error': error.message});
      },
    );

    if (mounted) {
      state = state.copyWith(isProcessing: false);
    }
  }

  bool _validate() {
    final emailError = ValidationUtils.validateEmail(state.email);
    final passwordError = ValidationUtils.validatePassword(state.password);
    final confirmError = ValidationUtils.validateConfirmPassword(
      state.password,
      state.confirmPassword,
    );
    final usernameError = ValidationUtils.validateUsername(state.username);

    state = state.copyWith(
      emailErrorMessage: emailError,
      emailError: emailError != null,
      passwordErrorMessage: passwordError,
      passwordError: passwordError != null,
      confirmPasswordErrorMessage: confirmError,
      confirmPasswordError: confirmError != null,
      usernameErrorMessage: usernameError,
      usernameError: usernameError != null,
    );

    return emailError == null &&
        passwordError == null &&
        confirmError == null &&
        usernameError == null;
  }
}
