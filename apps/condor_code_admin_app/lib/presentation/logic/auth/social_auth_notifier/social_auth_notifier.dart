import 'package:condorcode_admin/presentation/logic/auth/social_auth_notifier/social_auth_state.dart';
import 'package:condorcode_admin/presentation/logic/providers.dart';
import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final socialAuthProvider =
    StateNotifierProvider.autoDispose<SocialAuthNotifier, SocialAuthState>(
      (ref) => SocialAuthNotifier(
        ref: ref,
        authRepository: ref.watch(authRepositoryProvider),
      ),
    );

class SocialAuthNotifier extends StateNotifier<SocialAuthState> {
  SocialAuthNotifier({required this.ref, required this.authRepository})
    : super(const SocialAuthState());

  final Ref ref;
  final AuthRepository authRepository;

  Future<void> continueWithGoogle() async {
    state = state.copyWith(isSigningWithGoogle: true);

    final result = await authRepository.signInWithGoogle();

    result.fold(
      onSuccess: (_) async {},
      onError: (error) {
        state = state.copyWith(commonErrorMessage: error.message);
      },
    );

    if (mounted) {
      state = state.copyWith(isSigningWithGoogle: false);
    }
  }

  //TODO(WeakDroid): Uncomment and implement login with Apple later
  // Future<AfterAuthActionType?> continueWithApple() async {
  //   try {
  //     state = state.copyWith(isSigningWithApple: true);
  //     final credentials = await getIt<AuthRepository>().signInWithApple();
  //     if (credentials?.user != null) return _checkUserProfile();
  //   } catch (e, trace) {
  //     Logger.print(data: e, stackTrace: trace, from: '$runtimeType.loginWithApple');
  //   } finally {
  //     if (mounted) {
  //       state = state.copyWith(isSigningWithApple: false);
  //     }
  //   }
  //
  //   return null;
  // }
}
