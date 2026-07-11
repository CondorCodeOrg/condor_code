import 'package:condor_code/ui/base/provider/events/base/events_stream_provider.dart';

class TestScreenEventsProvider extends EventsStreamProvider<TestScreenAction> {}

enum TestScreenAction {
  loaded,
  failedToLoad,
  rightAnswer,
  wrongAnswer,
  workOnMistakes,
  loseHearts,
  move,
  finish,
}
