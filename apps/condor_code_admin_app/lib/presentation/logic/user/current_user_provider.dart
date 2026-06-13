import 'dart:async';

import 'package:condorcode_admin/presentation/logic/providers.dart';
import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, User?>(
  (ref) => CurrentUserNotifier(ref),
);

class CurrentUserNotifier extends StateNotifier<User?> {
  CurrentUserNotifier(this._ref) : super(null) {
    _subscription = _ref
        .read(authRepositoryProvider)
        .authStateChanges
        .listen(_onAuthUser);
  }

  final Ref _ref;
  late final StreamSubscription<User?> _subscription;
  int _loadGeneration = 0;

  AuthRepository get _authRepository => _ref.read(authRepositoryProvider);

  Future<void> _onAuthUser(User? user) async {
    if (user == null) {
      _loadGeneration++;
      state = null;
      return;
    }

    final gen = ++_loadGeneration;
    state = user;

    final roleName = await _authRepository.getUserRole();
    if (gen != _loadGeneration) {
      return;
    }

    final role = UserRole.values.firstWhere(
      (e) => e.name == roleName,
      orElse: () => UserRole.user,
    );
    if (state?.id == user.id) {
      state = User(
        id: user.id,
        email: user.email,
        fullName: user.fullName,
        role: role,
      );
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final isAdminProvider = FutureProvider<bool>((ref) async {
  final userId = ref.watch(currentUserProvider.select((u) => u?.id));
  if (userId == null) {
    return false;
  }
  final roleName = await ref.read(authRepositoryProvider).getUserRole();
  final role = UserRole.values.firstWhere(
    (e) => e.name == roleName,
    orElse: () => UserRole.user,
  );
  return role == UserRole.admin;
});
