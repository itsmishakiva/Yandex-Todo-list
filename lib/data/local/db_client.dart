import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/task_model.dart';

class DBClient {
  DBClient();

  static late Future<Database> database;

  static Future<void> openDataBase() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
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
          ' color INTEGER )',
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

  Future<List<TaskModel>> getAllTasks() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return TaskModel(
        id: maps[i]['id'],
        createdAt: maps[i]['created_at'],
        done: maps[i]['done'],
        deadline: maps[i]['deadline'],
        updatedAt: maps[i]['changed_at'],
        text: maps[i]['text'],
        importance: maps[i]['importance'],
      );
    });
  }
}
