import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/main.dart';

import '../../domain/task_model.dart';

class WebService {
  int? revision;
  final Ref ref;

  WebService(this.ref);

  Future<void> getRevision() async {
    if (revision == null) {
      await getTasks();
    }
    return;
  }

  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://beta.mrdekk.ru/todobackend',
      headers: {'Authorization': 'Bearer Brafham'},
    ),
  );

  Future<void> syncData(List<TaskModel> tasks) async {
    getRevision();
    List<Map<String, dynamic>> apiTasks = [];
    for (var element in tasks) {
      apiTasks.add(element.toApiMap());
    }
    try {
      Response response = await dio.patch(
        '/list',
        options: Options(headers: {
          "X-Last-Known-Revision": revision,
          "Host": "beta.mrdekk.ru",
          "Content-Length": jsonEncode({'list': apiTasks}).length,
        }, contentType: 'application/json'),
        data: jsonEncode({'list': apiTasks}),
      );
      revision = response.data['revision'];
    } catch (e) {
      ref.read(loggerProvider).fine('ERROR SYNCING WEB $e');
    }
  }

  Future<List<TaskModel>> getTasks() async {
    try {
      Response response = await dio.get('/list');
      List<TaskModel> results = [];
      for (Map<String, dynamic> task in response.data['list']) {
        results.add(TaskModel.fromApiMap(task));
      }
      revision = response.data['revision'];
      return results;
    } catch (e) {
      ref.read(loggerProvider).fine('ERROR GETTING TASKS FROM WEB $e');
      return [];
    }
  }

  void updateTask(TaskModel task) async {
    getRevision();
    try {
      Response response = await dio.put(
        '/list/${task.id}',
        options: Options(headers: {
          'X-Last-Known-Revision': revision,
          "Host": "beta.mrdekk.ru",
          "Content-Length": jsonEncode({'element': task.toApiMap()}).length,
        }, contentType: 'application/json'),
        data: jsonEncode({'element': task.toApiMap()}),
      );
      revision = response.data['revision'];
    } catch (e) {
      ref.read(loggerProvider).fine('UPDATING TASK WEB ERROR $e');
    }
  }

  Future<bool> removeTask(TaskModel task) async {
    getRevision();
    bool result = false;
    try {
      Response response = await dio.delete(
        '/list/${task.id}',
        options: Options(
          validateStatus: (status) {
            if (status == null) return false;
            if (status >= 200 && status < 300) {
              return true;
            }
            if (status == 404) {
              result = true;
            }
            return false;
          },
          headers: {
            'X-Last-Known-Revision': revision,
          },
          contentType: 'application/json',
        ),
      );
      revision = response.data['revision'];
      return true;
    } catch (e) {
      ref.read(loggerProvider).fine('DELETING TASK WEB ERROR $e');
      return result;
    }
  }

  void addTask(TaskModel task) async {
    getRevision();
    try {
      Response response = await dio.post(
        '/list',
        options: Options(headers: {
          'X-Last-Known-Revision': revision,
          "Host": "beta.mrdekk.ru",
          "Content-Length": jsonEncode({'element': task.toApiMap()}).length,
        }, contentType: 'application/json'),
        data: jsonEncode({'element': task.toApiMap()}),
      );
      revision = response.data['revision'];
    } catch (e) {
      ref.read(loggerProvider).fine('ADDING TASK WEB ERROR $e');
    }
  }
}
