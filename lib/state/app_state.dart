import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pomodoro_state.dart';
import 'stats_state.dart';
import 'gpa_state.dart';
import 'calendar_state.dart';

enum MascotMood { idle, focusing, resting, happy, sad }

final pomodoroProvider = ChangeNotifierProvider((ref) {
  final pomodoro = PomodoroState();
  final stats = ref.read(statsProvider);
  pomodoro.onSessionComplete = (minutes) => stats.addMinutes(minutes);
  return pomodoro;
});

final statsProvider = ChangeNotifierProvider((ref) => StatsState());
final gpaProvider = ChangeNotifierProvider((ref) => GpaState());
final calendarProvider = ChangeNotifierProvider((ref) => CalendarState());

final mascotMoodProvider = Provider((ref) {
  final pomodoro = ref.watch(pomodoroProvider);
  final stats = ref.watch(statsProvider);

  if (pomodoro.isRunning && pomodoro.mode == PomodoroMode.focus)
    return MascotMood.focusing;
  if (!pomodoro.isRunning && pomodoro.secondsLeft < PomodoroState.focusDuration)
    return MascotMood.resting;
  if (stats.streak >= 3) return MascotMood.happy;
  if (stats.totalMinutes == 0) return MascotMood.sad;
  return MascotMood.idle;
});
