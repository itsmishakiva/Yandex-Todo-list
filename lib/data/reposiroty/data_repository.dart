import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:todo_list/data/local/db_client.dart';
import 'package:todo_list/data/web/web_service.dart';
import 'package:todo_list/providers.dart';

import '../../domain/task_model.dart';

ChangeNotifierProvider<DataRepository> dataProvider =
    ChangeNotifierProvider<DataRepository>(
  (ref) =>
      DataRepository(DBClient(), WebService(ref.read(loggerProvider)), ref),
);

class DataRepository with ChangeNotifier {
  final DBClient _dbClient;
  final WebService _webService;
  final Ref? ref;
  bool synced = false;
  static String? _id;

  DataRepository(this._dbClient, this._webService, this.ref);

  static Future<void> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      _id = iosDeviceInfo.identifierForVendor ?? '';
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      _id = androidDeviceInfo.id ?? '';
    }
    _id = 'Strange device with no id';
  }

  Future<void> insertTask(TaskModel task) async {
    ref?.read(analyticsProvider).logEvent(name: 'task_added');
    task = task.copyWith(deviceId: _id);
    await _dbClient.insertTask(task);
    notifyListeners();
    _webService.addTask(task);
  }

  Future<void> updateTask(TaskModel task) async {
    ref?.read(analyticsProvider).logEvent(name: 'task_updated');
    task = task.copyWith(deviceId: _id);
    await _dbClient.updateTask(task);
    notifyListeners();
    _webService.updateTask(task);
  }

  Future<void> removeTask(TaskModel task) async {
    ref?.read(analyticsProvider).logEvent(name: 'task_removed');
    _dbClient.updateTask(task.copyWith(isDeleted: true));
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
    var tasks = await _webService.getTasks();
    for (TaskModel webTask in tasks) {
      bool found = false;
      for (TaskModel dbTask in activeTasks) {
        if (webTask.id == dbTask.id &&
            (webTask.changedAt ?? 0) > (dbTask.changedAt ?? 0)) {
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
              controller.add(await _dbClient.getActiveTasks());
            } catch (e) {
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
