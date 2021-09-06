import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_app/database/repository.dart';
import 'package:todo_app/models/task.dart';

class TaskProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Repository repo = Repository();

  List<Task> listTasks = [];

  Future<void> addATask(Task task) async {
    task.id = await (await repo.database)?.insert("Task", task.toMap());
    listTasks.add(task);
    notifyListeners();
  }

  Future<List<Task>> fetchAllTasks() async {
    // await repo.openDatabase();
    print('fetch all tasks');
    List<Map<String, Object?>>? data = [];
    try {
      data = await (await repo.database)?.query(
        "Task",
        columns: [columnId, columnComplete, columnTitle, columnTime],
        // where: '$columnId = ?',
        // whereArgs: [id],
      );
    } catch (e) {
      print('error: $e');
    }

    if (data!.length > 0) {
      print("have data");
      listTasks = data.map((task) => Task.fromMap(task)).toList();
      notifyListeners();
    }

    return listTasks;
  }

  Future<void> deleteATask(int id) async {
    if (id == -1) return;

    (await repo.database)
        ?.delete("Task", where: '$columnId = ?', whereArgs: [id]);

    int taskIndex = listTasks.indexWhere((element) => element.id == id);
    listTasks.removeAt(taskIndex);
    notifyListeners();
  }

  Future<void> updateATask(Task task) async {
    (await repo.database)?.update("Task", task.toMap(),
        where: '$columnId = ?', whereArgs: [task.id]);

    int taskIndex = listTasks.indexWhere((element) => element.id == task.id);
    print('taskIndex: $taskIndex');
    listTasks[taskIndex] = task;
    print('updated tasks: ' +
        listTasks.map((e) => jsonEncode(e.toMap())).toList().toString());
    notifyListeners();
  }
}
