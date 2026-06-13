import 'package:condorcode_admin/presentation/logic/auth/auth_state.dart';
import 'package:condorcode_admin/presentation/logic/providers.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/legacy.dart';

final authProvider = StateNotifierProvider.autoDispose<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.watch(authRepositoryProvider)),
);

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._authRepository) : super(const AuthState());
  final AuthRepository _authRepository;

  Future<void> logout() async => await _authRepository.logout();
}
