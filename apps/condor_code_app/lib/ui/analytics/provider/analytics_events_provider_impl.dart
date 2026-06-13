import 'package:condor_code/ui/analytics/analytics_constants.dart';
import 'package:condor_code/ui/analytics/analytics.dart';
import 'package:condor_code/ui/analytics/provider/analytics_events_provider.dart';

class AnalyticsEventsProviderImpl implements AnalyticsEventsProvider {
  final Analytics analytics;

  AnalyticsEventsProviderImpl(this.analytics);

  @override
  void onEnterScreenTransition({
    required String screenId,
    required String title,
  }) {
    analytics.setCurrentScreen(
      screenName: screenId,
      screenClassOverride: title,
    );
    analytics.logEvent(AnalyticsEventName.screenView, {
      AnalyticsPropertyName.screenId: screenId,
      AnalyticsPropertyName.screenTitle: title,
    });
  }

  @override
  void onExitScreenTransition({
    required String screenId,
    required String title,
  }) {
    // Firebase Analytics tracks screen views automatically on entry;
    // exit transitions are typically not logged separately.
  }

  @override
  void onUserLogin() {
    analytics.logEvent(AnalyticsEventName.userLogin, {});
  }

  @override
  void onUserLogout() {
    analytics.identifyUser(null);
    analytics.logEvent(AnalyticsEventName.userLogout, {});
  }
}
