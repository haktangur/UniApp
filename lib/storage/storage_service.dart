import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static const String _statsBox = 'stats';
  static const String _gpaBox = 'gpa';
  static const String _calendarBox = 'calendar';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_statsBox);
    await Hive.openBox(_gpaBox);
    await Hive.openBox(_calendarBox);
  }

  // Stats
  static Box get stats => Hive.box(_statsBox);

  // GPA
  static Box get gpa => Hive.box(_gpaBox);

  // Calendar
  static Box get calendar => Hive.box(_calendarBox);
}
