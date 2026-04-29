class EventModel {
  final String title;
  final String dateKey;

  const EventModel({required this.title, required this.dateKey});

  Map<String, dynamic> toMap() => {'title': title, 'dateKey': dateKey};

  factory EventModel.fromMap(Map map) {
    return EventModel(
      title: (map['title'] as String?) ?? '',
      dateKey: (map['dateKey'] as String?) ?? '',
    );
  }
}
