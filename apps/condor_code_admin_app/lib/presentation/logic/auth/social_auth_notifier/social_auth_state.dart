import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_auth_state.freezed.dart';

@freezed
sealed class SocialAuthState with _$SocialAuthState {
  const factory SocialAuthState({
    @Default(false) bool isSigningWithGoogle,
    //TODO: Implement Apple Sign In and anonymous sign in
    @Default(false) bool isSigningWithApple,
    @Default(false) bool isSigningAnonymously,
    String? commonErrorMessage,
  }) = _SocialAuthState;

  const SocialAuthState._();

  bool get isSigning => isSigningWithGoogle || isSigningWithApple;
}
