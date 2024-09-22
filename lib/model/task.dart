class Task {
  static const String collectionName = 'tasks';
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  Task({
    this.id = '',
    required this.title,
    required this.dateTime,
    required this.description,
    this.isDone = false,
  });

  Task.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'] as String,
          title: data['title'] as String,
          description: data['description'] as String,
          dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
          isDone: data['isDone'] as bool,
        );

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isDone': isDone,
    };
  }
}
