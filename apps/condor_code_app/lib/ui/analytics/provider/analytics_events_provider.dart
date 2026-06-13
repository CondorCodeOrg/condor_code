abstract class AnalyticsEventsProvider {
  void onUserLogin();

  void onUserLogout();

  void onEnterScreenTransition({
    required String screenId,
    required String title,
  });

  void onExitScreenTransition({
    required String screenId,
    required String title,
  });
}
