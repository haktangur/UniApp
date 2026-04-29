import 'package:flutter/material.dart';
import '../storage/storage_service.dart';

class DayStats {
  final String label;
  int minutes;

  DayStats({required this.label, this.minutes = 0});
}

class StatsState extends ChangeNotifier {
  final List<DayStats> weeklyData = [
    DayStats(label: 'Pt'),
    DayStats(label: 'Sa'),
    DayStats(label: 'Ça'),
    DayStats(label: 'Pe'),
    DayStats(label: 'Cu'),
    DayStats(label: 'Ct'),
    DayStats(label: 'Pz'),
  ];

  void loadFromStorage(Map raw) {
    try {
      for (final day in weeklyData) {
        final saved = raw[day.label];
        if (saved is int) day.minutes = saved;
      }
      notifyListeners();
    } catch (_) {}
  }

  void addMinutes(int minutes) {
    final index = DateTime.now().weekday - 1;
    weeklyData[index].minutes += minutes;
    _save();
    notifyListeners();
  }

  void _save() {
    final map = {for (final d in weeklyData) d.label: d.minutes};
    StorageService.stats.put('weekly', map);

    final todayKey = _todayKey();
    final current = StorageService.stats.get(todayKey) ?? 0;
    final todayIndex = DateTime.now().weekday - 1;
    StorageService.stats.put(
      todayKey,
      current + weeklyData[todayIndex].minutes,
    );
  }

  String _todayKey() {
    final now = DateTime.now();
    return 'day_${now.year}_${now.month}_${now.day}';
  }

  int minutesForDate(DateTime date) {
    final key = 'day_${date.year}_${date.month}_${date.day}';
    return StorageService.stats.get(key) ?? 0;
  }

  int get streak {
    int count = 0;
    for (final d in weeklyData.reversed) {
      if (d.minutes > 0)
        count++;
      else
        break;
    }
    return count;
  }

  int get totalMinutes => weeklyData.fold(0, (sum, d) => sum + d.minutes);

  String get totalFormatted {
    final h = totalMinutes ~/ 60;
    final m = totalMinutes % 60;
    return h > 0 ? '${h}s ${m}dk' : '${m}dk';
  }

  int get maxMinutes {
    if (weeklyData.every((d) => d.minutes == 0)) return 1;
    return weeklyData.map((d) => d.minutes).reduce((a, b) => a > b ? a : b);
  }
}
