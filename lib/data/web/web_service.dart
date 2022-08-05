import 'dart:convert';

import 'package:dio/dio.dart';

import '../../domain/task_model.dart';

class WebService {
  late int revision;

  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://beta.mrdekk.ru/todobackend',
      headers: {'Authorization': 'Bearer Brafham'},
    ),
  );

  Future<void> syncData(List<TaskModel> tasks) async {
    List<Map<String, dynamic>> apiTasks = [];
    for (var element in tasks) {
      apiTasks.add(element.toApiMap());
    }
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
  }

  Future<List<TaskModel>> getTasks() async {
    Response response = await dio.get('/list');
    List<TaskModel> results = [];
    for (Map<String, dynamic> task in response.data['list']) {
      results.add(TaskModel.fromApiMap(task));
    }
    revision = response.data['revision'];
    return results;
  }

  void updateTask(TaskModel task) async {
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
  }

  Future<bool> removeTask(TaskModel task) async {
    try {
      Response response = await dio.delete(
        '/list/${task.id}',
        options: Options(headers: {
          'X-Last-Known-Revision': revision,
        }, contentType: 'application/json'),
      );
      revision = response.data['revision'];
      return true;
    } catch(e) {
      return false;
    }
  }

  void addTask(TaskModel task) async {
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
  }
}
