abstract class Analytics {
  String get sessionId;

  Future<void> logEvent(String name, Map<String, dynamic> parameters);

  Future<void> setCurrentScreen({
    required String screenName,
    String? screenClassOverride,
  });

  Future<void> setUserId(String? userId);

  Future<void> setUserProperty({required String name, required String? value});

  Future<void> identifyUser(String? userId);
}
