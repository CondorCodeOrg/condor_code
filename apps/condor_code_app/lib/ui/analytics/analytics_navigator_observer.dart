import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:flutter/material.dart';

class AnalyticsNavigatorObserver extends NavigatorObserver {
  final Analytics analytics;

  AnalyticsNavigatorObserver(this.analytics);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) _log(newRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) _log(previousRoute);
  }

  void _log(Route<dynamic> route) {
    final name = route.settings.name ?? 'unknown';
    analytics.logEvent('screen_view', {
      'screen_name': name,
      'screen_class': route.runtimeType.toString(),
    });
    analytics.setCurrentScreen(
      screenName: name,
      screenClassOverride: route.runtimeType.toString(),
    );
  }
}
