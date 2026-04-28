import 'package:flutter/material.dart';

class CalendarState extends ChangeNotifier {
  DateTime selectedDay = DateTime.now();
  final Map<String, List<String>> _events = {};

  String _key(DateTime d) => '${d.year}-${d.month}-${d.day}';

  List<String> eventsFor(DateTime d) => _events[_key(d)] ?? [];

  void selectDay(DateTime d) {
    selectedDay = d;
    notifyListeners();
  }

  void addEvent(DateTime d, String title) {
    if (title.trim().isEmpty) return;
    _events.putIfAbsent(_key(d), () => []).add(title.trim());
    notifyListeners();
  }

  void removeEvent(DateTime d, int index) {
    _events[_key(d)]?.removeAt(index);
    notifyListeners();
  }

  bool hasEvents(DateTime d) => eventsFor(d).isNotEmpty;
}
