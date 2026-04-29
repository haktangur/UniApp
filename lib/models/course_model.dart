class CourseModel {
  final String name;
  final String grade;
  final int credit;

  const CourseModel({
    required this.name,
    required this.grade,
    required this.credit,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'grade': grade,
    'credit': credit,
  };

  factory CourseModel.fromMap(Map map) => CourseModel(
    name: map['name'] ?? '',
    grade: map['grade'] ?? 'AA',
    credit: map['credit'] ?? 3,
  );
}
