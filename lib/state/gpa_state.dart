import 'package:flutter/material.dart';
import '../models/course_model.dart';

const Map<String, double> gradePoints = {
  'AA': 4.0,
  'BA': 3.5,
  'BB': 3.0,
  'CB': 2.5,
  'CC': 2.0,
  'DC': 1.5,
  'DD': 1.0,
  'FF': 0.0,
};

class Course {
  String name;
  String grade;
  int credit;

  Course({this.name = '', this.grade = 'AA', this.credit = 3});
}

class GpaState extends ChangeNotifier {
  final List<Course> courses = [Course()];

  void addCourse() {
    courses.add(Course());
    notifyListeners();
  }

  void removeCourse(int index) {
    if (courses.length > 1) {
      courses.removeAt(index);
      notifyListeners();
    }
  }

  void loadFromStorage(List<CourseModel> loaded) {
    courses
      ..clear()
      ..addAll(
        loaded.map(
          (c) => Course(name: c.name, grade: c.grade, credit: c.credit),
        ),
      );
    notifyListeners();
  }

  void updateName(int index, String name) {
    courses[index].name = name;
    notifyListeners();
  }

  void updateGrade(int index, String grade) {
    courses[index].grade = grade;
    notifyListeners();
  }

  void updateCredit(int index, int credit) {
    courses[index].credit = credit;
    notifyListeners();
  }

  double get gpa {
    double totalPoints = 0;
    int totalCredits = 0;
    for (final c in courses) {
      totalPoints += (gradePoints[c.grade] ?? 0) * c.credit;
      totalCredits += c.credit;
    }
    if (totalCredits == 0) return 0;
    return totalPoints / totalCredits;
  }
}
