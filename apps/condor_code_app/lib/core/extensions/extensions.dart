import 'dart:async';

extension CancelStreamSubs on List<StreamSubscription> {
  void cancelAll() {
    forEach((element) {
      element.cancel();
    });
  }
}
