import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/provider/task_provider.dart';

void main() {
  sqfliteFfiInit();
  test('simple sqflite example', () async {
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    expect(await db.getVersion(), 0);
    await db.close();
  });
  test("Add", () async {
    await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    final taskProvider = TaskProvider();
    int lengthBefore = taskProvider.listTasks.length;
    print('on task');
    Task task = Task.fromInput('title', 10);
    print('start adding');
    await taskProvider.addATask(task);

    expect(taskProvider.listTasks.length, lengthBefore + 1);
  });
}
