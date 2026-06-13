import 'package:condor_code/ui/analytics/analytics.dart';

class MockAnalyticsImpl implements Analytics {
  @override
  Future<void> identifyUser(String? userId) async {}

  @override
  Future<void> logEvent(String name, Map<String, dynamic> parameters) async {}

  @override
  String get sessionId => 'mock-session-id';

  @override
  Future<void> setCurrentScreen({
    required String screenName,
    String? screenClassOverride,
  }) async {}

  @override
  Future<void> setUserId(String? userId) async {}

  @override
  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {}
}
