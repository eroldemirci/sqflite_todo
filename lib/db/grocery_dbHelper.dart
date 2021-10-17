import 'dart:async';
import 'dart:io';

import 'package:flutter_sqflite_todo/model/grocery_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class GroceryDatabaseHelper {
  GroceryDatabaseHelper._privateConstructor();
  static final GroceryDatabaseHelper instance =
      GroceryDatabaseHelper._privateConstructor();
  final String tableName = 'groceries';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnLastName = 'lastname';
  final String columnComment = 'comment';

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDB();

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'groceries.db');
    print(path);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableName(
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT,
     
      )''');
  }

  Future<List<Grocery>> getGroceries() async {
    Database db = await instance.database;
    var groceries = await db.query(tableName, orderBy: 'id');
    List<Grocery> groceryList = groceries.isNotEmpty
        ? groceries.map((e) => Grocery.fromMap(e)).toList()
        : [];
    return groceryList;
  }

  Future<int> add(Grocery grocery) async {
    Database db = await instance.database;
    return await db.insert(tableName, grocery.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Grocery grocery) async {
    Database db = await instance.database;
    return await db.update(tableName, grocery.toMap(),
        where: 'id = ?', whereArgs: [grocery.id]);
  }
}
