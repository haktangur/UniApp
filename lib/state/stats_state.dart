import 'package:flutter/material.dart';

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

  // Pomodoro her seans bittiğinde bunu çağırır
  void addMinutes(int minutes) {
    final day = DateTime.now().weekday - 1; // 0=Pt, 6=Pz
    weeklyData[day].minutes += minutes;
    notifyListeners();
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
