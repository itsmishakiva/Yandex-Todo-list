import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/task_model.dart';

class DBClient {
  final Ref ref;

  DBClient(this.ref);

  static late Future<Database> database;

  static Future<void> openDataBase() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'todo_db.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks('
          'id TEXT PRIMARY KEY,'
          ' text TEXT,'
          ' done INTEGER,'
          ' importance TEXT,'
          ' changed_at INTEGER,'
          ' created_at INTEGER,'
          ' deadline INTEGER,'
          ' last_updated_by TEXT,'
          ' is_deleted INTEGER )',
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
  }

  Future<void> removeTask(TaskModel task) async {
    Database db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> updateTask(TaskModel task) async {
    Database db = await database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<List<TaskModel>> getRemovedTasks() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    List<TaskModel> tasks = [];
    for (int i = 0; i < maps.length; i++) {
      if (maps[i]['is_deleted'] == 1) {
        tasks.add(TaskModel.fromMap(maps[i]));
      }
    }
    return tasks;
  }

  Future<List<TaskModel>> getActiveTasks() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    List<TaskModel> tasks = [];
    for (int i = 0; i < maps.length; i++) {
      if (maps[i]['is_deleted'] != 1) {
        tasks.add(TaskModel.fromMap(maps[i]));
      }
    }
    return tasks;
  }
}
