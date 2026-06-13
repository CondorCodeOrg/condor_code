import 'package:flutter/foundation.dart';

/// Centralized logging and incident reporting mixin that bridges console output with remote crashlytics services.
/// Logging config
mixin Logger {
  static const String _tag = 'CondorCode-Auth';

  static Function(
    dynamic incident,
    Map<String, Object?>? data,
    String? reason,
    StackTrace? stackTrace,
  )?
  reportIncident;

  static void print({
    required dynamic data,
    StackTrace? stackTrace,
    String? from,
    Map<String, Object?>? extras,
  }) {
    _debugPrint(data, stackTrace: stackTrace, from: from, extras: extras);
  }

  static void _debugPrint(
    dynamic data, {
    StackTrace? stackTrace,
    String? from,
    Map<String, Object?>? extras,
  }) {
    var logMessage = '[$_tag] :: ';
    if (from != null && from.isNotEmpty) logMessage += '[$from] ';
    logMessage += '$data';
    if (stackTrace != null) {
      logMessage += '\n$stackTrace';
    }

    debugPrint(logMessage);

    if (kDebugMode) return;

    if (data is Error || data is Exception) {
      final Object incidentToReport = data;
      final StackTrace reportStackTrace = stackTrace ?? StackTrace.current;
      final extractedData = <String, Object?>{
        if (from != null) 'from_method': from,
        ...?extras,
      };
      String? reasonForReport;

      // TODO: Move to data.
      // if (incidentToReport is FirebaseException) {
      //   final firebaseWrapper = FirebaseWrapperException.from(
      //     origin: incidentToReport,
      //     additionalData: extras,
      //   );
      //   extractedData.addAll(firebaseWrapper.customData ?? {});
      //   reasonForReport = firebaseWrapper.message;
      //   reportStackTrace = firebaseWrapper.stackTrace;
      //   incidentToReport = firebaseWrapper;
      // }
      _reportIncident(
        incidentToReport,
        extractedData,
        reasonForReport,
        reportStackTrace,
      );
    }
  }

  static void _reportIncident(
    dynamic incident,
    Map<String, Object?>? customData,
    String? reason,
    StackTrace? stackTrace,
  ) {
    try {
      final st =
          stackTrace ??
          (incident is Error ? incident.stackTrace : StackTrace.current);
      reportIncident?.call(incident, customData, reason, st);
      debugPrint('[$_tag] :: Incident reported: $incident');
      if (customData != null && customData.isNotEmpty) {
        debugPrint('[$_tag] :: Custom Data: $customData');
      }
      if (reason != null) debugPrint('[$_tag] :: Reason: $reason');
    } catch (e, trace) {
      debugPrint('[$_tag] :: Logger.reportIncident Failed: $e\n$trace');
    }
  }
}
