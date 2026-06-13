import 'dart:async';

import 'package:condor_code/config/app_config.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';

// TODO: rewrite to cubit.
/// Drives [GoRouter.refreshListenable] for staging role checks after Firebase auth changes.
class StagingGateNotifier extends ChangeNotifier {
  StagingGateNotifier(this._authRepository, this._analytics, this._appConfig) {
    _subscription = _authRepository.authStateChanges.listen(_onAuthChanged);
  }

  final AuthRepository _authRepository;
  final Analytics _analytics;
  final AppConfig _appConfig;

  late final StreamSubscription<User?> _subscription;
  int _generation = 0;

  bool _hasFirebaseSession = false;

  /// Whether Firestore role has been loaded for the current session user.
  bool _roleResolved = true;

  /// Allowed when there is no session, or role is `admin` / `tester`.
  bool _allowedOnStaging = true;

  /// Redirect logic should wait until role is known for the signed-in user.
  bool get roleGatePending =>
      _appConfig.isStaging && _hasFirebaseSession && !_roleResolved;

  bool get shouldBlockStagingAccess =>
      _appConfig.isStaging &&
      _hasFirebaseSession &&
      _roleResolved &&
      !_allowedOnStaging;

  bool get hasFirebaseSession => _hasFirebaseSession;

  Future<void> _onAuthChanged(User? user) async {
    if (user == null) {
      _generation++;
      _hasFirebaseSession = false;
      _roleResolved = true;
      _allowedOnStaging = true;
      await _analytics.identifyUser(null);
      if (kDebugMode) {
        debugPrint(
          '[StagingGate] no Firebase session (signed out or never logged in)',
        );
      }
      notifyListeners();
      return;
    }

    await _analytics.identifyUser(user.id);

    final gen = ++_generation;
    _hasFirebaseSession = true;
    _roleResolved = false;
    _allowedOnStaging = false;
    notifyListeners();

    String? roleName;
    try {
      roleName = await _authRepository.getUserRole();
    } catch (e, st) {
      // Firestore rules often deny `users/{uid}` reads for non-privileged roles —
      // without this branch `_roleResolved` never flips true and the gate never redirects.
      if (kDebugMode) {
        debugPrint(
          '[StagingGate] getUserRole FAILED — treating as no staging access. '
          'uid=${user.id} email=${user.email}',
        );
        debugPrint('[StagingGate] $e');
        debugPrint('$st');
      }
      roleName = null;
    }

    if (gen != _generation) {
      return;
    }

    _roleResolved = true;

    final role = UserRole.fromString(roleName);
    _allowedOnStaging = role == UserRole.admin || role == UserRole.tester;

    if (kDebugMode) {
      debugPrint(
        '[StagingGate] uid=${user.id} email=${user.email} '
        'role="${roleName ?? '(none)'}" parsed=${role.name} '
        'allowedOnStaging=$_allowedOnStaging',
      );
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
