import 'dart:async';

import 'package:condor_code/ui/screens/lesson/utils/enum/timer_action.dart';

class TimerController {
  int seconds = 0;

  TimerController();

  StreamController<TimerAction> actionStreamController = StreamController();

  void start() {
    actionStreamController.add(TimerAction.start);
  }

  void stop() {
    actionStreamController.add(TimerAction.stop);
  }
}
