import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'storage_service.dart';
import '../state/app_state.dart';
import '../state/gpa_state.dart';
import '../state/calendar_state.dart';
import '../state/stats_state.dart';
import '../models/course_model.dart';
import '../models/event_model.dart';

final appLoaderProvider = FutureProvider<void>((ref) async {
  await _loadGpa(ref.read(gpaProvider));
  await _loadCalendar(ref.read(calendarProvider));
  await _loadStats(ref.read(statsProvider));
});

Future<void> _loadGpa(GpaState state) async {
  try {
    final raw = StorageService.gpa.get('courses');
    if (raw == null || raw is! List || raw.isEmpty) return;
    final list = raw
        .whereType<Map>()
        .map((e) => CourseModel.fromMap(e))
        .toList();
    if (list.isNotEmpty) state.loadFromStorage(list);
  } catch (_) {}
}

Future<void> _loadCalendar(CalendarState state) async {
  try {
    final raw = StorageService.calendar.get('events');
    if (raw == null || raw is! List || raw.isEmpty) return;
    final list = raw
        .whereType<Map>()
        .map((e) => EventModel.fromMap(e))
        .toList();
    if (list.isNotEmpty) state.loadFromStorage(list);
  } catch (_) {}
}

Future<void> _loadStats(StatsState state) async {
  try {
    final raw = StorageService.stats.get('weekly');
    if (raw == null || raw is! Map || raw.isEmpty) return;
    state.loadFromStorage(raw);
  } catch (_) {}
}
