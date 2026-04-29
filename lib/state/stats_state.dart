import 'package:flutter/material.dart';

class DayStats {
  final String label;
  final int minutes;

  const DayStats({required this.label, required this.minutes});
}

class StatsState extends ChangeNotifier {
  // Pomodoro bağlandığında bu liste oradan güncellenecek
  final List<DayStats> weeklyData = [
    const DayStats(label: 'Pt', minutes: 50),
    const DayStats(label: 'Sa', minutes: 75),
    const DayStats(label: 'Ça', minutes: 25),
    const DayStats(label: 'Pe', minutes: 100),
    const DayStats(label: 'Cu', minutes: 60),
    const DayStats(label: 'Ct', minutes: 0),
    const DayStats(label: 'Pz', minutes: 40),
  ];

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

  int get maxMinutes =>
      weeklyData.map((d) => d.minutes).reduce((a, b) => a > b ? a : b);
}
