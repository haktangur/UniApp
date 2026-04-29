import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../storage/storage_service.dart';

class CalendarState extends ChangeNotifier {
  DateTime selectedDay = DateTime.now();
  final Map<String, List<String>> _events = {};

  String _key(DateTime d) => '${d.year}-${d.month}-${d.day}';

  List<String> eventsFor(DateTime d) => _events[_key(d)] ?? [];

  bool hasEvents(DateTime d) => eventsFor(d).isNotEmpty;

  void loadFromStorage(List<EventModel> loaded) {
    _events.clear();
    for (final e in loaded) {
      _events.putIfAbsent(e.dateKey, () => []).add(e.title);
    }
    notifyListeners();
  }

  void selectDay(DateTime d) {
    selectedDay = d;
    notifyListeners();
  }

  void addEvent(DateTime d, String title) {
    if (title.trim().isEmpty) return;
    _events.putIfAbsent(_key(d), () => []).add(title.trim());
    _save();
    notifyListeners();
  }

  void removeEvent(DateTime d, int index) {
    _events[_key(d)]?.removeAt(index);
    _save();
    notifyListeners();
  }

  void _save() {
    final list = <Map>[];
    for (final entry in _events.entries) {
      for (final title in entry.value) {
        list.add(EventModel(title: title, dateKey: entry.key).toMap());
      }
    }
    StorageService.calendar.put('events', list);
  }
}
