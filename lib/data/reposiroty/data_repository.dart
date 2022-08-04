import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/data/db_client.dart';
import 'package:todo_list/data/web_service.dart';

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
    await _dbClient.removeTask(task);
    notifyListeners();
    _webService.removeTask(task);
  }

  Future<void> syncData() async {
    _webService.syncData(await _dbClient.getAllTasks());
  }

  Stream<List<TaskModel>> getAllTasksStream() {
    final Stream<List<TaskModel>> tasks = (() {
      late final StreamController<List<TaskModel>> controller;
      controller = StreamController<List<TaskModel>>(
        onListen: () async {
          List<TaskModel> tasks = await _dbClient.getAllTasks();
          controller.add(tasks);
          await _webService.getTasks();
          await syncData();
          await controller.close();
        },
      );
      return controller.stream;
    })();
    return tasks;
  }
}