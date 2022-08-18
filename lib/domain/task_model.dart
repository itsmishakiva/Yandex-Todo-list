class TaskModel {
  final String id;
  String text;
  bool done;
  bool isDeleted;
  int? createdAt;
  int? deadline;
  int? updatedAt;
  String? importance;
  String? deviceId;

  TaskModel({
    required this.id,
    required this.text,
    this.createdAt,
    this.done = false,
    this.deadline,
    this.updatedAt,
    this.importance = 'basic',
    this.isDeleted = false,
    this.deviceId,
  });

  factory TaskModel.copy({
    required TaskModel task,
  }) {
    return TaskModel(
      id: task.id,
      createdAt: task.createdAt,
      done: task.done,
      deadline: task.deadline,
      updatedAt: task.updatedAt,
      text: task.text,
      importance: task.importance,
      deviceId: task.deviceId,
      isDeleted: task.isDeleted,
    );
  }

  factory TaskModel.fromApiMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      text: map['text'] as String,
      createdAt: map['created_at'],
      done: map['done'],
      deadline: map['deadline'],
      updatedAt: map['changed_at'],
      importance: map['importance'],
      deviceId: map['last_updated_by'],
      isDeleted: false,
    );
  }

  Map<String, dynamic> toApiMap() {
    return {
      'id': id,
      'text': text,
      'created_at': createdAt,
      'done': done,
      'deadline': deadline,
      'changed_at': updatedAt,
      'importance': importance,
      'last_updated_by': deviceId
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      createdAt: map['created_at'],
      done: map['done'] == 1,
      deadline: map['deadline'],
      updatedAt: map['changed_at'],
      text: map['text'],
      importance: map['importance'],
      deviceId: map['last_updated_by'],
      isDeleted: map['is_deleted'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'created_at': createdAt,
      'done': done ? 1 : 0,
      'deadline': deadline,
      'changed_at': updatedAt,
      'importance': importance,
      'last_updated_by': deviceId,
      'is_deleted': isDeleted ? 1 : 0
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
