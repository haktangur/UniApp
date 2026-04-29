import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pomodoro_state.dart';
import 'stats_state.dart';

enum MascotMood { idle, focusing, happy, sad }

class AppState {
  final MascotMood mood;
  final PomodoroState pomodoro;
  final StatsState stats;

  const AppState({
    required this.mood,
    required this.pomodoro,
    required this.stats,
  });
}

final pomodoroProvider = ChangeNotifierProvider((ref) => PomodoroState());
final statsProvider = ChangeNotifierProvider((ref) => StatsState());

final mascotMoodProvider = Provider((ref) {
  final pomodoro = ref.watch(pomodoroProvider);
  final stats = ref.watch(statsProvider);

  if (pomodoro.isRunning) return MascotMood.focusing;
  if (stats.streak >= 3) return MascotMood.happy;
  if (stats.totalMinutes == 0) return MascotMood.sad;
  return MascotMood.idle;
});
