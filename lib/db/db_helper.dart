import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:todotask/models/category.dart';
import 'package:todotask/models/task.dart';

class DBHelper {
  Database _db;
  final int _version = 1;
  final String _tableName = 'tasks';
  final String _tableCategory = 'categories';

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> initDb() async {
    try {
      String _path = '${await getDatabasesPath()}tasks.db';
      _db = await openDatabase(_path,
          version: _version, onCreate: _onCreate, onUpgrade: _onUpgrade);

      print('Database created =========');
    } catch (e) {
      print('initDb Method Error! = $e');
    }
    return _db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY,title TEXT,note TEXT,date TEXT,isCompleted INTEGER,categoryId INTEGER);');
    await db.execute(
        'CREATE TABLE $_tableCategory(id INTEGER PRIMARY KEY,name TEXT,icon TEXT,color TEXT);');
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print('onUpgrade ====================================\n');
  }

  Future<int> insertTask(Task task) async {
    Database mydb = await db;
    print('Insert ====');

    return await mydb.insert(_tableName, task.toMap());
  }

  Future<int> insertCategory(Category category) async {
    Database mydb = await db;
    print('Insert ====');
    return await mydb.insert(_tableCategory, category.toMap());
  }

  Future<int> delete(int id) async {
    Database mydb = await db;
    print('Delete ====');

    return await mydb.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateTaskStatus(int id, int status) async {
    Database mydb = await db;
    print('Update ====');
    return await mydb.rawUpdate(
        'UPDATE $_tableName SET isCompleted = ? WHERE id = ?', [status, id]);
  }

  Future updateTaskInformation(
    Task task,
  ) async {
    Database mydb = await db;
    print('Update ====');
    //return
    await mydb.rawUpdate(
        'UPDATE $_tableName SET title = ? ,note = ? , date = ?, isCompleted = ? , categoryId = ?  WHERE id = ?',
        [
          task.title,
          task.note,
          task.date,
          task.isCompleted,
          task.categoryId,
          task.id
        ]);
  }

  Future<List<Map<String, Object>>> query(String tableName) async {
    Database mydb = await db;
    print('Query ====');
    return await mydb.query(tableName);
  }
}
