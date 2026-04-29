import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pomodoro_state.dart';
import 'stats_state.dart';

enum MascotMood { idle, focusing, resting, happy, sad }

// Tek provider instance — tüm uygulama aynı state'i kullanır
final pomodoroProvider = ChangeNotifierProvider((ref) {
  final pomodoro = PomodoroState();
  final stats = ref.read(statsProvider);

  // Pomodoro seans bitince stats'a yaz
  pomodoro.onSessionComplete = (minutes) => stats.addMinutes(minutes);

  return pomodoro;
});

final statsProvider = ChangeNotifierProvider((ref) => StatsState());

// Mascot mood — stats ve pomodoro'dan türetiliyor, kendi state'i yok
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
