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

  factory CourseModel.fromMap(Map map) {
    return CourseModel(
      name: (map['name'] as String?) ?? '',
      grade: (map['grade'] as String?) ?? 'AA',
      credit: (map['credit'] as int?) ?? 3,
    );
  }
}
