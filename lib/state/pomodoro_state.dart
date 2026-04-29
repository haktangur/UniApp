import 'dart:async';
import 'package:flutter/material.dart';

enum PomodoroMode { focus, breakTime }

class PomodoroState extends ChangeNotifier {
  static const int focusDuration = 25 * 60;
  static const int breakDuration = 5 * 60;

  PomodoroMode mode = PomodoroMode.focus;
  int secondsLeft = focusDuration;
  bool isRunning = false;
  Timer? _timer;

  // Stats'a bağlanmak için — app_state.dart setter ile atar
  void Function(int minutes)? onSessionComplete;
  // Pomodoro ekranındaki snackbar için
  VoidCallback? onComplete;

  double get progress => 1 - (secondsLeft / _totalSeconds);
  int get _totalSeconds =>
      mode == PomodoroMode.focus ? focusDuration : breakDuration;

  String get timeString {
    final m = (secondsLeft ~/ 60).toString().padLeft(2, '0');
    final s = (secondsLeft % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void start() {
    isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsLeft > 0) {
        secondsLeft--;
        notifyListeners();
      } else {
        _switchMode();
      }
    });
    notifyListeners();
  }

  void pause() {
    _timer?.cancel();
    isRunning = false;
    notifyListeners();
  }

  void reset() {
    _timer?.cancel();
    isRunning = false;
    secondsLeft = _totalSeconds;
    notifyListeners();
  }

  void _switchMode() {
    _timer?.cancel();

    // Odak seansı bittiyse dakikaları stats'a bildir
    if (mode == PomodoroMode.focus) {
      onSessionComplete?.call(focusDuration ~/ 60);
    }

    onComplete?.call();
    mode = mode == PomodoroMode.focus
        ? PomodoroMode.breakTime
        : PomodoroMode.focus;
    secondsLeft = _totalSeconds;
    isRunning = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
