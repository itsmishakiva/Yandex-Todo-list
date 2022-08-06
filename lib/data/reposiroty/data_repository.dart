import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:todo_list/data/local/db_client.dart';
import 'package:todo_list/data/web/web_service.dart';

import '../../domain/task_model.dart';

class DataRepository with ChangeNotifier {
  final DBClient _dbClient;
  final WebService _webService;
  bool synced = false;

  DataRepository(this._dbClient, this._webService);

  Future<String> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor ?? '';
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId ?? '';
    }
    return 'Strange device with no id';
  }

  void insertTask(TaskModel task) async {
    task.deviceId = await getId();
    await _dbClient.insertTask(task);
    notifyListeners();
    _webService.addTask(task);
  }

  void updateTask(TaskModel task) async {
    task.deviceId = await getId();
    await _dbClient.updateTask(task);
    notifyListeners();
    _webService.updateTask(task);
  }

  void removeTask(TaskModel task) async {
    _dbClient.updateTask(task..isDeleted = true);
    notifyListeners();
    bool removed = await _webService.removeTask(task);
    if (removed) {
      await _dbClient.removeTask(task);
    }
  }

  Future<void> _syncData() async {
    synced = true;
    await _webService.getTasks();
    for (TaskModel task in await _dbClient.getRemovedTasks()) {
      bool removed = await _webService.removeTask(task);
      if (removed) {
        await _dbClient.removeTask(task);
      }
    }
    List<TaskModel> activeTasks = await _dbClient.getActiveTasks();
    for (TaskModel webTask in await _webService.getTasks()) {
      bool found = false;
      for (TaskModel dbTask in activeTasks) {
        if (webTask.id == dbTask.id && (webTask.updatedAt ?? 0) > (dbTask.updatedAt ?? 0)) {
          await _dbClient.updateTask(webTask);
        } else if (webTask.id == dbTask.id) {
          found = true;
          break;
        }
      }
      if (!found) {
        await _dbClient.insertTask(webTask);
      }
    }
    await _webService.syncData(await _dbClient.getActiveTasks());
  }

  Stream<List<TaskModel>> getAllTasksStream() {
    final Stream<List<TaskModel>> tasks = (() {
      late final StreamController<List<TaskModel>> controller;
      controller = StreamController<List<TaskModel>>(
        onListen: () async {
          List<TaskModel> tasks = await _dbClient.getActiveTasks();
          controller.add(tasks);
          if (!synced) {
            try {
              await _syncData();
            } catch(e) {
              if (kDebugMode) {
                Logger log = Logger('data_logger');
                log.fine(e);
              }
            }
          }
          await controller.close();
        },
      );
      return controller.stream;
    })();
    return tasks;
  }
}