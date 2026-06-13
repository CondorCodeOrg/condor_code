import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
sealed class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(false) bool isProcessing,
    @Default('') String username,
    @Default('') String email,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default(false) bool isPasswordVisible,
    @Default(false) bool isConfirmPasswordVisible,
    @Default(false) bool emailError,
    @Default(false) bool usernameError,
    @Default(false) bool passwordError,
    @Default(false) bool confirmPasswordError,
    String? usernameErrorMessage,
    String? emailErrorMessage,
    String? passwordErrorMessage,
    String? confirmPasswordErrorMessage,
    Map<String, String>? commonErrorMessage,
  }) = _SignUpState;

  const SignUpState._();

  bool get hasErrorMessage =>
      commonErrorMessage?.entries.firstOrNull?.value.isNotEmpty ?? false;

  bool get canSave =>
      username.isNotEmpty &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty;
}
