import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  initDatabase() async {
    print('init db');
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'todo_db_sqflite');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    print('create table task');
    String sqlQuery =
        "CREATE TABLE Task(id INTEGER PRIMARY KEY, title TEXT not null, complete INTEGER not null, estimatedTime INTEGER)";
    await database.execute(sqlQuery);
  }
}
