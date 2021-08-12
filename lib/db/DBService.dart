import 'dart:async';

import 'package:first_flutter_app/db/DBServiceInterface.dart';
import 'package:first_flutter_app/models/Record.dart';
import 'package:first_flutter_app/repositories/RecordRepositoryInterface.dart';
import 'package:sqflite/sqflite.dart';

class DBService implements DBServiceInterface {
  Database? _db;

  Future<Database> get database async {
    Database? db = this._db;
    if (db != null) return db;

    final String databasesPath = await getDatabasesPath();
    final String path = databasesPath + 'dev3.db';

    db = await openDatabase(path, version: 1, onCreate: onCreate);

    return db;
  }

  Future<CreateRecordResponse> insertRecord(CreateRecordRequest record) async {
    final Database db = await database;

    await db.insert('record', record.toMap());
    await Future.delayed(new Duration(seconds: 3));

    return CreateRecordResponse();
  }

  Future<List<Record>> getRecordsByMonth(int month, int categoryId,
      [int? labelId]) async {
    return [Record(0, 0, 0, DateTime.now())];
  }
}

FutureOr<void> onCreate(Database db, int version) {
  print('onCreate');
  return db.execute('''
      CREATE TABLE record (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER,
        label_id INTEGER,
        amount REAL NOT NULL,
        created_at TEXT NOT NULL
      );
      CREATE TABLE category(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
  ''');
}
