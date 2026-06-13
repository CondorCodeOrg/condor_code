import 'package:condorcode_admin/generated/l10n/l10n.dart';
import 'package:condorcode_admin/presentation/logic/auth/login_email_notifier/login_with_email_state.dart';
import 'package:condorcode_admin/presentation/logic/providers.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ui_kit/ui_kit.dart';

final loginWithEmailProvider =
    StateNotifierProvider.autoDispose<
      LoginWithEmailNotifier,
      LoginWithEmailState
    >(
      (ref) => LoginWithEmailNotifier(
        ref: ref,
        authRepository: ref.watch(authRepositoryProvider),
      ),
    );

class LoginWithEmailNotifier extends StateNotifier<LoginWithEmailState> {
  LoginWithEmailNotifier({required this.ref, required this.authRepository})
    : super(const LoginWithEmailState());

  final Ref ref;
  final AuthRepository authRepository;

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void updateEmail(String email) {
    state = state.copyWith(
      email: email,
      emailError: false,
      emailErrorMessage: null,
    );
  }

  void updatePassword(String password) {
    state = state.copyWith(
      password: password,
      passwordError: false,
      passwordErrorMessage: null,
    );
  }

  Future<void> signIn() async {
    if (!_validate()) return;
    state = state.copyWith(isProcessing: true);

    final result = await authRepository.signInWithEmailPassword(
      email: state.email,
      password: state.password,
    );

    result.fold(
      onSuccess: (_) async {},
      onError: (error) {
        state = state.copyWith(emailErrorMessage: error.message);
      },
    );

    state = state.copyWith(isProcessing: false);
  }

  bool _validate() {
    final isEmailValid = RegExpUtils.email.hasMatch(state.email);
    final isPasswordValid = state.password.trim().isNotEmpty;

    state = state.copyWith(
      emailError: !isEmailValid,
      passwordError: !isPasswordValid,
      emailErrorMessage: isEmailValid ? null : S.current.pleaseEnterAValidEmail,
    );

    return isEmailValid && isPasswordValid;
  }
}
