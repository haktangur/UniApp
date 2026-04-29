class StatsModel {
  final String dayLabel;
  final int minutes;

  const StatsModel({required this.dayLabel, required this.minutes});

  Map<String, dynamic> toMap() => {'dayLabel': dayLabel, 'minutes': minutes};

  factory StatsModel.fromMap(Map map) =>
      StatsModel(dayLabel: map['dayLabel'] ?? '', minutes: map['minutes'] ?? 0);
}
