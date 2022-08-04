class TaskModel {
  String id;
  String text;
  int? createdAt;
  int? done;
  int? deadline;
  int? updatedAt;
  String? importance;

  TaskModel({
    required this.id,
    required this.text,
    this.createdAt,
    this.done = 0,
    this.deadline,
    this.updatedAt,
    this.importance = 'basic',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'createdAt': createdAt,
      'done': done,
      'deadline': deadline,
      'updatedAt': updatedAt,
      'importance': importance,
    };
  }

  @override
  String toString() {
    return 'Task(id: $id, text: $text,'
        ' createdAt: $createdAt,'
        ' done : $done, deadline: $deadline,'
        ' updatedAt: $updatedAt,'
        ' importance: $importance,)';
  }
}
