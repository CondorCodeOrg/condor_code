import 'dart:async';

import 'package:flutter/material.dart';

import 'package:condor_code/ui/screens/lesson/utils/enum/timer_action.dart';
import 'package:condor_code/ui/screens/lesson/utils/timer_controller.dart';

class LessonTimer extends StatefulWidget {
  final TimerController timerController;

  const LessonTimer({super.key, required this.timerController});

  @override
  TimerState createState() => TimerState();
}

class TimerState extends State<LessonTimer> {
  Timer? _timer;
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    widget.timerController.actionStreamController.stream.listen((timerAction) {
      switch (timerAction) {
        case TimerAction.start:
          startTimer();
        case TimerAction.stop:
          stopTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String formattedTime = getFormattedTime();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(formattedTime, style: const TextStyle(fontSize: 20))],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    if (_isTimerRunning) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        widget.timerController.seconds++;
      });
    });

    setState(() {
      _isTimerRunning = true;
    });
  }

  void stopTimer() {
    if (!_isTimerRunning) return;

    _timer?.cancel();
    setState(() {
      _isTimerRunning = true;
    });
  }

  String getFormattedTime() {
    final int hours = widget.timerController.seconds ~/ 3600;
    final int minutes = (widget.timerController.seconds % 3600) ~/ 60;
    final int seconds = widget.timerController.seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
