import 'package:firebase_core/firebase_core.dart';

/// A decorator for FirebaseException that formats error messages and attaches contextual metadata for better debugging.
class FirebaseWrapperException implements Exception {
  FirebaseWrapperException._(
    this._exception,
    this.customData,
    this.message,
    this.stackTrace,
  );

  factory FirebaseWrapperException.from({
    required FirebaseException origin,
    Map<String, Object?>? additionalData,
  }) {
    var effectiveMessage = origin.message ?? origin.code;
    if (origin.plugin.isNotEmpty) {
      effectiveMessage =
          '[${origin.plugin}/${origin.code}] ${origin.message ?? origin.code}';
    }

    final allData = <String, Object?>{
      'firebase_code': origin.code,
      'firebase_plugin': origin.plugin,
      'firebase_message': origin.message,
      if (additionalData != null) ...additionalData,
    };

    return FirebaseWrapperException._(
      origin,
      allData,
      effectiveMessage,
      origin.stackTrace ?? StackTrace.current,
    );
  }

  final Map<String, Object?>? customData;
  final FirebaseException _exception;
  final String message;
  final StackTrace? stackTrace;

  String get code => _exception.code;

  String get plugin => _exception.plugin;

  FirebaseException get originalException => _exception;

  @override
  String toString() =>
      'FirebaseWrapperException: '
      '$message\nOriginal FirebaseException: ${_exception.toString()}';
}
