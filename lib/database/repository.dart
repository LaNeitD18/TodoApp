import 'package:sqflite/sqflite.dart';
import 'package:todo_app/database/database_connection.dart';

class Repository {
  late DatabaseConnection _databaseConnection;
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    await openMyDatabase();
    return _database;
  }

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  Future<void> openMyDatabase() async {
    print("open db");
    _database = await _databaseConnection.initDatabase();
    print('db after init: $_database');
  }

  Future close() async => _database?.close();
}
