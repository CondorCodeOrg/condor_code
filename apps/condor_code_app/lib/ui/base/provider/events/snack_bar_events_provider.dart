import 'package:condor_code/ui/base/provider/events/base/events_stream_provider.dart';

class SnackBarEventsProvider extends EventsStreamProvider<SnackBarEvent> {}

// TODO: Move to separate ui module
class SnackBarEvent {
  final String message;
  final SnackBarType type;

  SnackBarEvent.success(this.message) : type = SnackBarType.success;

  SnackBarEvent.error(this.message) : type = SnackBarType.error;

  SnackBarEvent.info(this.message) : type = SnackBarType.info;
}

enum SnackBarType { info, error, success }
