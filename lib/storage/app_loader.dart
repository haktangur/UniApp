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
  final box = StorageService.gpa;
  final raw = box.get('courses');
  if (raw == null) return;
  final list = (raw as List).map((e) => CourseModel.fromMap(e)).toList();
  state.loadFromStorage(list);
}

Future<void> _loadCalendar(CalendarState state) async {
  final box = StorageService.calendar;
  final raw = box.get('events');
  if (raw == null) return;
  final list = (raw as List).map((e) => EventModel.fromMap(e)).toList();
  state.loadFromStorage(list);
}

Future<void> _loadStats(StatsState state) async {
  final box = StorageService.stats;
  final raw = box.get('weekly');
  if (raw == null) return;
  state.loadFromStorage(raw as Map);
}
