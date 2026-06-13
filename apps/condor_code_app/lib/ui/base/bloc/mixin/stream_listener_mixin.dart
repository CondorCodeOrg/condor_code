import 'dart:async';

import 'package:condor_code/core/extensions/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Base class for a Bloc that listens to multiple streams and manages their subscriptions.
/// Usage:
/// 1. Extend this class with your specific state type.
/// 2. Add your stream subscriptions to the `subscriptions` list. (subscriptions.add(yourStream.listen(...)))
/// 3. Call `pauseStreamListening()` to pause all stream listeners.
/// 4. Call `resumeStreamListening()` to resume all stream listeners.
mixin StreamListenerMixin<T> on BlocBase<T> {
  /// Add all your streams subscriptions to this array.
  @protected
  List<StreamSubscription> subscriptions = [];
  bool isActive = true;

  void pauseStreamListening() {
    isActive = false;
  }

  void resumeStreamListening() {
    isActive = true;
  }

  @override
  Future<void> close() {
    subscriptions.cancelAll();
    return super.close();
  }
}
