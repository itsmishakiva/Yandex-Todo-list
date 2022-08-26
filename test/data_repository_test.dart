import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo_list/data/local/db_client.dart';
import 'package:todo_list/data/reposiroty/data_repository.dart';
import 'package:todo_list/data/web/web_service.dart';
import 'package:todo_list/domain/task_model.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  DBClient.database = databaseFactoryFfi.openDatabase(
    inMemoryDatabasePath,
    options: OpenDatabaseOptions(
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
    ),
  );
  test('Adding task db test', () async {
    var dbClient = DBClient();
    var webService = WebService(null);
    var repos = DataRepository(dbClient, webService, null);
    TaskModel task = TaskModel(
      id: 'test',
      text: DateTime.now().toIso8601String(),
    );
    await repos.insertTask(task);
    List<TaskModel> tasks = await dbClient.getActiveTasks();
    expect(tasks[0].id, task.id);
  });
  test('Removing task db test', () async {
    var dbClient = DBClient();
    var webService = WebService(null);
    var repos = DataRepository(dbClient, webService, null);
    TaskModel task = TaskModel(
      id: 'test',
      text: DateTime.now().toIso8601String(),
    );
    await repos.insertTask(task);
    await repos.removeTask(task);
    int result = (await dbClient.getActiveTasks()).length;
    expect(result, 0);
  });
  test('Updating task db test', () async {
    var dbClient = DBClient();
    var webService = WebService(null);
    var repos = DataRepository(dbClient, webService, null);
    TaskModel task = TaskModel(
      id: 'test',
      text: DateTime.now().toIso8601String(),
    );
    await repos.insertTask(task);
    await repos.updateTask(task.copyWith(text: 'TEST'));
    String result = (await dbClient.getActiveTasks())[0].text;
    expect(result, 'TEST');
  });
}
