import 'package:condor_code/ui/base/provider/events/snack_bar_events_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';

mixin BaseBlocMixin {
  abstract final SnackBarEventsProvider snackBarEventsProvider;

  void showErrorSnackBar(String message) {
    snackBarEventsProvider.addEvent(SnackBarEvent.error(message));
  }

  /// Process a single DataResult.
  /// It handles success and error cases, showing a SnackBar for errors.
  @protected
  Future<void> processDataResult<T>(
    Future<DataResult<T>> result, {
    required ValueChanged<T> onSuccess,
    ValueChanged<ErrorResult<dynamic>>? onError,
  }) async {
    final dataResult = await result;
    dataResult.fold(
      onSuccess: (data) => onSuccess(data),
      onError: (error) {
        if (onError != null) {
          onError(error);
        } else {
          snackBarEventsProvider.addEvent(SnackBarEvent.error(error.message));
        }
      },
    );
  }

  /// Process two DataResult objects in parallel.
  ///
  /// Calls [onSuccess] with both values when both succeed.
  /// If either fails, a SnackBar is shown for each error and [onError]
  /// is called with any successfully loaded values.
  @protected
  Future<void> processDataResultCombine2<T, U>(
    Future<DataResult<T>> first,
    Future<DataResult<U>> second, {
    required void Function(T first, U second) onSuccess,
    void Function(ErrorResult<dynamic>? first, ErrorResult<dynamic>? second)?
    onError,
  }) async {
    final (firstResult, secondResult) = await (first, second).wait;

    T? firstData;
    U? secondData;
    ErrorResult<dynamic>? firstError;
    ErrorResult<dynamic>? secondError;

    firstResult.fold(
      onSuccess: (data) => firstData = data,
      onError: (error) => firstError = error,
    );

    secondResult.fold(
      onSuccess: (data) => secondData = data,
      onError: (error) => secondError = error,
    );

    if (firstError != null || secondError != null) {
      if (onError != null) {
        onError(firstError, secondError);
      } else {
        // TODO: Get from localisation.
        snackBarEventsProvider.addEvent(SnackBarEvent.error('Сталась помилка'));
      }
    } else {
      onSuccess(firstData as T, secondData as U);
    }
  }
}
