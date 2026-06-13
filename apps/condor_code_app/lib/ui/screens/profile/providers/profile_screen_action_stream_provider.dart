import 'package:condor_code/ui/base/provider/events/base/events_stream_provider.dart';

class ProfileScreenEventsProvider
    extends EventsStreamProvider<ProfileScreenAction> {}

enum ProfileScreenAction { loaded, loading }
