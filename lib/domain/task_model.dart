import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class TaskModel {
  late String id;
  late String text;
  int? createdAt;
  int? done;
  int? deadline;
  int? updatedAt;
  String? importance;
  static late String deviceId;

  static Future<void> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor ?? '';
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.androidId ?? '';
    }
  }

  TaskModel({
    required this.id,
    required this.text,
    this.createdAt,
    this.done = 0,
    this.deadline,
    this.updatedAt,
    this.importance = 'basic',
  });

  TaskModel.fromMap(Map<String, dynamic> map) {
    id = map['id'] as String;
    text = map['text'] as String;
    importance = map['importance'];
    deadline = map['deadline'];
    done = map['done'] ? 1 : 0;
    createdAt = map['created_at'];
    updatedAt = map['changed_at'];
  }

  Map<String, dynamic> toMap() {
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

  Map<String, dynamic> toApiMap() {
    return {
      'id': id,
      'text': text,
      'created_at': createdAt,
      'done': done == 0 ? false : true,
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
