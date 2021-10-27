import 'dart:async';

import 'package:first_flutter_app/db/DBServiceInterface.dart';
import 'package:first_flutter_app/models/Record.dart';
import 'package:first_flutter_app/repositories/RecordRepositoryInterface.dart';
import 'package:first_flutter_app/models/MainCategory.dart';
import 'package:first_flutter_app/models/SubCategory.dart';
import 'package:first_flutter_app/models/Label.dart';
import 'package:sqflite/sqflite.dart';

class DBService implements DBServiceInterface {
  Database? _db;

  Future<Database> get database async {
    Database? db = this._db;
    if (db != null) return db;

    final String databasesPath = await getDatabasesPath();
    final String path = databasesPath + 'dev50.db';

    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  Future<Record> insertRecord(CreateRecordReq req) async {
    final Database db = await database;

    final map = req.toMap();

    if (req.subCategoryId == null) {
      final SubCategory subCategory = await getUntitledSubCategory();
      map['sub_category_id'] = subCategory.id;
    }

    final int id = await db.insert('record', map);

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
        main_category.id AS main_category_id,
        main_category.name AS main_category_name,
        sub_category.id AS sub_category_id,
        sub_category.name AS sub_category_name,
        label.id AS label_id,
        label.name AS label_name
      FROM
        record
        LEFT OUTER JOIN main_category ON record.main_category_id = main_category.id
        LEFT OUTER JOIN sub_category ON record.sub_category_id = sub_category.id
        LEFT OUTER JOIN label ON record.label_id = label.id
      WHERE
        record.id = ?
    ''', [id]);

    print(result);
    print(result.first);

    final MainCategory mainCategory = MainCategory(
        result.first['main_category_id'], result.first['main_category_name']);
    final SubCategory subCategory = SubCategory(
        result.first['sub_category_id'], result.first['sub_category_name']);
    final Label label =
        Label(result.first['label_id'], result.first['label_name']);
    return Record(
        result.first['id'],
        result.first['amount'],
        result.first['month'],
        result.first['day'],
        mainCategory,
        subCategory,
        label);
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
        main_category.id AS main_category_id,
        main_category.name AS main_category_name,
        sub_category.id AS sub_category_id,
        sub_category.name AS sub_category_name,
        label.id AS label_id,
        label.name AS label_name
      FROM
        record
        LEFT OUTER JOIN main_category ON record.main_category_id = main_category.id
        LEFT OUTER JOIN sub_category ON record.sub_category_id = sub_category.id
        LEFT OUTER JOIN label ON record.label_id = label.id
      WHERE
        record.month = ?
    ''', [month]);

    print(result);

    return List.generate(result.length, (i) {
      print(result[i]);

      final MainCategory mainCategory = MainCategory(
          result[i]['main_category_id'], result[i]['main_category_name']);
      final SubCategory subCategory = SubCategory(
          result[i]['sub_category_id'], result[i]['sub_category_name']);
      final Label label = Label(result[i]['label_id'], result[i]['label_name']);
      return Record(result.first['id'], result[i]['amount'], result[i]['month'],
          result[i]['day'], mainCategory, subCategory, label);
    });
  }

  Future<MainCategory> insertMainCategory(String name) async {
    final Database db = await database;

    final int id = await db.insert('main_category', {'name': name});

    return await findMainCategoryById(id);
  }

  Future<MainCategory> findMainCategoryById(int id) async {
    final Database db = await database;

    final List<Map<String, dynamic>> result =
        await db.query('main_category', where: 'id = ?', whereArgs: [id]);
    return MainCategory(result.first['id'], result.first['name']);
  }

  Future<MainCategory> getUntitledMainCategory() async {
    final Database db = await database;

    final List<Map<String, dynamic>> result = await db
        .query('main_category', where: 'name = ?', whereArgs: ['untitled']);
    return MainCategory(result.first['id'], result.first['name']);
  }

  Future<SubCategory> insertSubCategory(String name) async {
    final Database db = await database;

    final int id = await db.insert('sub_category', {'name': name});

    return await findSubCategoryById(id);
  }

  Future<SubCategory> findSubCategoryById(int id) async {
    final Database db = await database;

    final List<Map<String, dynamic>> result =
        await db.query('sub_category', where: 'id = ?', whereArgs: [id]);
    return SubCategory(result.first['id'], result.first['name']);
  }

  Future<SubCategory> getUntitledSubCategory() async {
    final Database db = await database;

    final List<Map<String, dynamic>> result = await db
        .query('sub_category', where: 'name = ?', whereArgs: ['untitled']);
    return SubCategory(result.first['id'], result.first['name']);
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

  Future<Label> getUntitledLabel() async {
    final Database db = await database;

    final List<Map<String, dynamic>> result =
        await db.query('label', where: 'name = ?', whereArgs: ['untitled']);
    return Label(result.first['id'], result.first['name']);
  }
}

FutureOr<void> onCreate(Database db, int version) async {
  print('onCreate');
  await db.execute('''
      CREATE TABLE record (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        main_category_id INTEGER,
        sub_category_id INTEGER,
        label_id INTEGER,
        amount REAL NOT NULL,
        month int NOT NULL,
        day int NOT NULL
      );
  ''');
  await db.execute('''
      CREATE TABLE main_category (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
  ''');
  await db.execute('''
      CREATE TABLE sub_category (
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
  await db.execute('''
      INSERT INTO main_category (name)
      VALUES ('untitled');
  ''');
  await db.execute('''
      INSERT INTO sub_category (name)
      VALUES ('untitled');
  ''');
  await db.execute('''
      INSERT INTO label (name)
      VALUES ('untitled');
  ''');

  // await db.insert('main_category', {'name': 'untitled'});
  // await db.insert('sub_category', {'name': 'untitled'});
  // await db.insert('label', {'name': 'untitled'});

  // final DateTime now = DateTime.now();
  // final int month = now.month;
  // final int day = now.day;

  // final DBService dbService = DBService();
  // final MainCategory mainCategory = await dbService.getUntitledMainCategory();
  // final SubCategory subCategory = await dbService.getUntitledSubCategory();
  // final Label label = await dbService.getUntitledLabel();
  // final CreateRecordReq req =
  //     CreateRecordReq(0, mainCategory.id, subCategory.id, label.id, month, day);

  // await dbService.insertRecord(req);
}
