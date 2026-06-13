import 'package:condor_code/ui/base/bloc/mixin/stream_listener_mixin.dart';
import 'package:condor_code/ui/base/provider/events/snack_bar_events_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit that listens to SnackBarEventsProvider and emits SnackBarEvent to global SnackBar showcase.
class SnackBarCubit extends Cubit<SnackBarEvent?> with StreamListenerMixin {
  final SnackBarEventsProvider snackBarEventsProvider;

  SnackBarCubit(this.snackBarEventsProvider) : super(null) {
    subscriptions.add(
      snackBarEventsProvider.events.listen((snackBarEvent) {
        emit(snackBarEvent);
      }),
    );
  }
}
