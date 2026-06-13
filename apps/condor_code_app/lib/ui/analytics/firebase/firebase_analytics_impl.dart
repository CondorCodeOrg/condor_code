import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/analytics_constants.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class FirebaseAnalyticsImpl implements Analytics {
  final FirebaseAnalytics _firebaseAnalytics;
  @override
  final String sessionId;

  FirebaseAnalyticsImpl()
    : _firebaseAnalytics = FirebaseAnalytics.instance,
      sessionId = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  Future<void> logEvent(String name, Map<String, dynamic> parameters) async {
    final enriched = <String, dynamic>{
      ...parameters,
      AnalyticsPropertyName.sessionId: sessionId,
    };

    if (kDebugMode) {
      print('Logging event: $name, parameters: $enriched');
    }

    final analytics = _firebaseAnalytics;

    await analytics.logEvent(
      name: name,
      parameters: enriched.cast<String, Object>(),
    );
  }

  @override
  Future<void> setCurrentScreen({
    required String screenName,
    String? screenClassOverride,
  }) async {
    final analytics = _firebaseAnalytics;

    await analytics.logEvent(
      name: AnalyticsEventName.screenView,
      parameters: {
        AnalyticsPropertyName.firebaseScreen: screenName,
        AnalyticsPropertyName.firebaseScreenClass:
            screenClassOverride ?? screenName,
      },
    );
  }

  @override
  Future<void> setUserId(String? userId) async {
    final analytics = _firebaseAnalytics;

    await analytics.setUserId(id: userId);
  }

  @override
  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    final analytics = _firebaseAnalytics;

    await analytics.setUserProperty(name: name, value: value);
  }

  @override
  Future<void> identifyUser(String? userId) async {
    final analytics = _firebaseAnalytics;

    await analytics.setUserId(id: userId);
    await analytics.setUserProperty(
      name: AnalyticsPropertyName.userId,
      value: userId,
    );
  }
}
