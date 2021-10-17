import 'dart:async';
import 'dart:io';

import 'package:flutter_sqflite_todo/model/note.dart';
import 'package:flutter_sqflite_todo/model/userComent_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  final String tableName = 'usercomments';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnLastName = 'lastname';
  final String columnDescription = 'description';
  final String columnActive = 'active';

  Future<Database> get database async => _database ??= await _initDB();

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'usercomments.db');
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
      $columnLastName TEXT,
      $columnDescription TEXT,
      $columnActive BOOLEAN
      )''');
  }

  Future<List<UserComent>> getCommentList() async {
    Database db = await instance.database;
    var comments = await db.query(tableName, orderBy: 'id');
    List<UserComent> commentsList = comments.isNotEmpty
        ? comments.map((e) => UserComent.fromMap(e)).toList()
        : [];
    return commentsList;
  }

  Future<int> addComment(UserComent comment) async {
    Database db = await instance.database;
    return await db.insert(tableName, comment.toJson());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(UserComent comment) async {
    Database db = await instance.database;
    return await db.update(tableName, comment.toJson(),
        where: 'id = ?', whereArgs: [comment.id]);
  }
}
