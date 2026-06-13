import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isProcessing,
    @Default(false) bool isAuthenticated,
    @Default('') String pin,
    @Default(false) bool pinError,
    String? errorMessage,
  }) = _AuthState;

  const AuthState._();

  bool get hasErrorMessage => errorMessage?.isNotEmpty ?? false;

  bool get canSubmit => !isProcessing && pin.isNotEmpty && !pinError;
}
