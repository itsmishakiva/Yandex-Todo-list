class TaskModel {
  late String id;
  late String text;
  int? createdAt;
  late bool done;
  int? deadline;
  int? updatedAt;
  String? importance;
  String? deviceId;
  late bool isDeleted;

  TaskModel({
    required this.id,
    required this.text,
    this.createdAt,
    this.done = false,
    this.deadline,
    this.updatedAt,
    this.importance = 'basic',
    this.isDeleted = false,
  });

  TaskModel.fromApiMap(Map<String, dynamic> map) {
    id = map['id'] as String;
    text = map['text'] as String;
    importance = map['importance'];
    deadline = map['deadline'];
    done = map['done'];
    createdAt = map['created_at'];
    updatedAt = map['changed_at'];
    isDeleted = false;
  }

  TaskModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    createdAt = map['created_at'];
    done = map['done'] == 1;
    deadline = map['deadline'];
    updatedAt = map['changed_at'];
    text = map['text'];
    importance = map['importance'];
    deviceId = map['last_updated_by'];
    isDeleted = map['is_deleted'] == 1;
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

  @override
  String toString() {
    return 'Task(id: $id, text: $text,'
        ' createdAt: $createdAt,'
        ' done : $done, deadline: $deadline,'
        ' updatedAt: $updatedAt,'
        ' importance: $importance,)';
  }
}
