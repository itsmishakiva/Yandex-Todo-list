import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/data/local/db_client.dart';
import 'package:todo_list/data/web/web_service.dart';

import '../../domain/task_model.dart';

class DataRepository with ChangeNotifier {
  final DBClient _dbClient;
  final WebService _webService;

  DataRepository(this._dbClient, this._webService);

  void insertTask(TaskModel task) async {
    await _dbClient.insertTask(task);
    notifyListeners();
    _webService.addTask(task);
  }

  void updateTask(TaskModel task) async {
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
    await _webService.getTasks();
    for (TaskModel task in await _dbClient.getRemovedTasks()) {
      bool removed = await _webService.removeTask(task);
      if (removed) {
        await _dbClient.removeTask(task);
      }
    }
    List<TaskModel> activeTasks = await _dbClient.getActiveTasks();
    await _webService.syncData(activeTasks);
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
  }

  Stream<List<TaskModel>> getAllTasksStream() {
    late final StreamController<List<TaskModel>> controller;
    controller = StreamController<List<TaskModel>>(
      onListen: () async {
        List<TaskModel> tasks = await _dbClient.getActiveTasks();
        controller.add(tasks);
        await _syncData();
        await controller.close();
      },
    );
    return controller.stream;
  }
}
