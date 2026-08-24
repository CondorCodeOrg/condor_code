import 'dart:async';

import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/provider/analytics_events_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';

/// Drives [GoRouter.refreshListenable] for prod/dev session checks.
class AuthSessionNotifier extends ChangeNotifier {
  AuthSessionNotifier(
    this._authRepository,
    this._analytics,
    this._analyticsEventsProvider,
  ) {
    _subscription = _authRepository.authStateChanges.listen(_onAuthChanged);
  }

  final AuthRepository _authRepository;
  final Analytics _analytics;
  final AnalyticsEventsProvider _analyticsEventsProvider;

  late final StreamSubscription<User?> _subscription;

  bool _hasFirebaseSession = false;

  bool get hasFirebaseSession => _hasFirebaseSession;

  Future<void> _onAuthChanged(User? user) async {
    _hasFirebaseSession = user != null;
    await _analytics.identifyUser(user?.id);
    if (user != null) {
      _analyticsEventsProvider.onUserLogin();
    }
    if (kDebugMode) {
      debugPrint(
        user == null
            ? '[AuthSession] no Firebase session'
            : '[AuthSession] uid=${user.id} email=${user.email}',
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
