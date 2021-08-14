import 'dart:async';

import 'package:first_flutter_app/db/DBServiceInterface.dart';
import 'package:first_flutter_app/models/Record.dart';
import 'package:first_flutter_app/repositories/RecordRepositoryInterface.dart';
import 'package:first_flutter_app/view_models/Category.dart';
import 'package:first_flutter_app/view_models/Label.dart';
import 'package:sqflite/sqflite.dart';

class DBService implements DBServiceInterface {
  Database? _db;

  Future<Database> get database async {
    Database? db = this._db;
    if (db != null) return db;

    final String databasesPath = await getDatabasesPath();
    final String path = databasesPath + 'dev19.db';

    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  Future<Record> insertRecord(CreateRecordReq req) async {
    final Database db = await database;

    final int id = await db.insert('record', req.toMap());

    return await findRecordById(id);
  }

  Future<Record> findRecordById(int id) async {
    final Database db = await database;

    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT
        record.id,
        record.amount,
        record.month,
        record.day,
        category.id AS category_id,
        category.name AS category_name,
        label.id AS label_id,
        label.name AS label_name
      FROM
        record
        LEFT OUTER JOIN category ON record.category_id = category.id
        LEFT OUTER JOIN label ON record.label_id = label.id
      WHERE
        record.id = ?
    ''', [id]);

    print(result);
    print(result.first);

    final Category category =
        Category(result.first['category_id'], result.first['category_name']);
    final Label label =
        Label(result.first['label_id'], result.first['label_name']);
    return Record(result.first['id'], result.first['amount'],
        result.first['month'], result.first['day'], category, label);
  }

  Future<List<Record>> getRecordsByMonth(int month, int categoryId,
      [int? labelId]) async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT
        record.id,
        record.amount,
        record.month,
        record.day,
        category.id AS category_id,
        category.name AS category_name,
        label.id AS label_id,
        label.name AS label_name
      FROM
        record
        LEFT OUTER JOIN category ON record.category_id = category.id
        LEFT OUTER JOIN label ON record.label_id = label.id
      WHERE
        record.month = ?
    ''', [month]);

    print(result);

    return List.generate(result.length, (i) {
      print(result[i]);

      final Category category =
          Category(result[i]['category_id'], result[i]['category_name']);
      final Label label = Label(result[i]['label_id'], result[i]['label_name']);
      return Record(result.first['id'], result[i]['amount'], result[i]['month'],
          result[i]['day'], category, label);
    });
  }

  Future<Category> insertCategory(String name) async {
    final Database db = await database;

    final int id = await db.insert('category', {'name': name});

    return await findCategoryById(id);
  }

  Future<Category> findCategoryById(int id) async {
    final Database db = await database;

    final List<Map<String, dynamic>> result =
        await db.query('category', where: 'id = ?', whereArgs: [id]);
    return Category(result.first['id'], result.first['name']);
  }

  Future<Label> insertLabel(String name) async {
    final Database db = await database;

    final int id = await db.insert('label', {'name': name});

    return await findLabelById(id);
  }

  Future<Label> findLabelById(int id) async {
    final Database db = await database;

    final List<Map<String, dynamic>> result =
        await db.query('label', where: 'id = ?', whereArgs: [id]);
    return Label(result.first['id'], result.first['name']);
  }
}

FutureOr<void> onCreate(Database db, int version) async {
  print('onCreate');
  await db.execute('''
      CREATE TABLE record (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER,
        label_id INTEGER,
        amount REAL NOT NULL,
        month int NOT NULL,
        day int NOT NULL
      );
  ''');
  await db.execute('''
      CREATE TABLE category (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
  ''');
  await db.execute('''
      CREATE TABLE label (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
  ''');
}
