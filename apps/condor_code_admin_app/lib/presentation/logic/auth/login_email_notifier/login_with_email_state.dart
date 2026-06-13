import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_with_email_state.freezed.dart';

@freezed
sealed class LoginWithEmailState with _$LoginWithEmailState {
  const factory LoginWithEmailState({
    @Default(false) bool isProcessing,
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isPasswordVisible,
    @Default(false) bool emailError,
    @Default(false) bool passwordError,
    String? emailErrorMessage,
    String? passwordErrorMessage,
  }) = _LoginWithEmailState;

  const LoginWithEmailState._();

  bool get hasErrorMessage =>
      emailErrorMessage?.isNotEmpty == true ||
      passwordErrorMessage?.isNotEmpty == true;

  bool get canSave =>
      !isProcessing &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      !emailError &&
      !passwordError;
}
