import 'package:condor_code/ui/base/provider/events/base/events_stream_provider.dart';

class LessonScreenEventsProvider
    extends EventsStreamProvider<LessonScreenAction> {}

enum LessonScreenAction {
  loaded,
  failedToLoad,
  rightAnswer,
  wrongAnswer,
  workOnMistakes,
  loseHearts,
  move,
  finish,
}
