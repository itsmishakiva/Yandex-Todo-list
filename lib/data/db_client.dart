import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../domain/task_model.dart';

class DBClient with ChangeNotifier{
  DBClient();

  static late Future<Database> database;

  static Future<void> openDataBase() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'tasks.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks('
          'id TEXT PRIMARY KEY,'
          ' text TEXT,'
          ' done INTEGER,'
          ' importance TEXT,'
          ' updatedAt INTEGER,'
          ' createdAt INTEGER,'
          ' deadline INTEGER)',
        );
      },
      version: 1,
    );
    return;
  }

  Future<void> insertTask(TaskModel task) async {
    Database db = await database;
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<void> removeTask(TaskModel task) async {
    Database db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [task.id],
    );
    notifyListeners();
  }

  Future<void> updateTask(TaskModel task) async {
    Database db = await database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    notifyListeners();
  }

  Future<List<TaskModel>> getAllTasks() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return TaskModel(
        id: maps[i]['id'],
        createdAt: maps[i]['createdAt'],
        done: maps[i]['done'],
        deadline: maps[i]['deadline'],
        updatedAt: maps[i]['updatedAt'],
        text: maps[i]['text'],
        importance: maps[i]['importance'],
      );
    });
  }
}
