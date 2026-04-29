class EventModel {
  final String title;
  final String dateKey; // format: yyyy-MM-dd

  const EventModel({required this.title, required this.dateKey});

  Map<String, dynamic> toMap() => {'title': title, 'dateKey': dateKey};

  factory EventModel.fromMap(Map map) =>
      EventModel(title: map['title'] ?? '', dateKey: map['dateKey'] ?? '');
}
