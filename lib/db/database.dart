import 'dart:io';

import 'package:carhelper/model/Inspection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  String inspectionTable = 'Inspection';
  String columnId = 'id';
  String columnNameInspection = 'nameInspection';
  String columnDescripshon = 'descripshon';
  String columnMileage = 'mileage';

  Future<Database> get databeses async {
    if(_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'Inspection.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $inspectionTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnNameInspection TEXT, '
        '$columnDescripshon TEXT, $columnMileage INTEGER)');
    print('create');
  }

  ///READ
    Future<List<Inspection>> getInspection() async {
    Database db = await this.databeses;
    final List<Map<dynamic, dynamic>> inspectionMapList = await db.query(inspectionTable);
    final List<Inspection> inspectionList = [];
    inspectionMapList.forEach((inspectionMap) {
      inspectionList.add(Inspection.fromMap(inspectionMap));
    });

    return inspectionList;
  }

  /// INSERT
  Future<Inspection> insertInspection(Inspection inspection) async {
    Database db = await this.databeses;
    inspection.id = await db.insert(inspectionTable, inspection.toMap(), nullColumnHack: columnId);
    print('add');
    return inspection;
  }

  /// UPDATE
  Future<int> updateInspection(Inspection inspection) async {
    Database db = await this.databeses;
    return await db.update(inspectionTable, inspection.toMap(),
        where: '$columnId = ?', whereArgs: [inspection.id]);
  }

  /// DELETE
  Future<int> deleteInspection(int id) async {
    Database db = await this.databeses;
    return await db.delete(
      inspectionTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
