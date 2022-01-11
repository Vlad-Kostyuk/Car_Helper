import 'dart:io';
import 'package:carhelper/data/model/Inspection.dart';
import 'package:carhelper/data/model/User.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'db_service/db_service.dart';

class DBProvider implements SQLDataService{
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  String inspectionTable = 'Inspection';
  String futureInspectionTable = 'futureInspection';
  String columnId = 'id';
  String columnNameInspection = 'nameInspection';
  String columnDescripshon = 'descripshon';
  String columnDate = 'date';
  String columnMileage = 'mileage';
  String color = 'color';

  String userTable = 'User';
  String columnNameUser = 'name';
  String columnMileageUser = 'mileage';
  String shotMileage = 'shotMileage';

  Future<Database> get databeses async {
    if(_database != null) return _database;

    User user = new User(null, 'Vlad', 0, 0);
    _database = await _initDB();
    await insertUser(user);
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
            '$columnDescripshon TEXT, $columnDate TEXT,  $columnMileage INTEGER, $color TEXT)');

    await db.execute(
        'CREATE TABLE $futureInspectionTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnNameInspection TEXT,'
            ' $columnDescripshon TEXT, $columnDate TEXT,  $columnMileage INTEGER, $color TEXT)');

    await db.execute(
        'CREATE TABLE $userTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnNameUser TEXT, $columnMileageUser INTEGER,'
            '$shotMileage INTEGER)');

    print('create');
  }

  ///READ OLD
  @override
    Future<List<Inspection>> getInspection() async {
    Database db = await this.databeses;
    final List<Map<dynamic, dynamic>> inspectionMapList = await db.query(inspectionTable);
    final List<Inspection> inspectionList = [];
    inspectionMapList.forEach((inspectionMap) {
      inspectionList.add(Inspection.fromMap(inspectionMap));
    });
    return inspectionList;
  }

  ///READ FUTURE
  @override
  Future<List<Inspection>> getFutureInspection() async {
    Database db = await this.databeses;
    final List<Map<dynamic, dynamic>> inspectionMapList = await db.query(futureInspectionTable);
    final List<Inspection> inspectionList = [];
    inspectionMapList.forEach((inspectionMap) {
      inspectionList.add(Inspection.fromMap(inspectionMap));
    });
    return inspectionList;
  }

  ///READ User
  @override
  Future<List<User>> getUser() async {
    Database db = await this.databeses;
    final List<Map<dynamic, dynamic>> userMapList = await db.query(userTable);
    final List<User> userList = [];
    userMapList.forEach((userMap) {
      userList.add(User.fromMap(userMap));
    });
    return userList;
  }

  /// INSERT
  @override
  Future<Inspection> insertInspection(Inspection inspection) async {
    Database db = await this.databeses;
    inspection.id = await db.insert(inspectionTable, inspection.toMap(), nullColumnHack: columnId);
    print('add');
    return inspection;
  }

  /// INSERT FUTURE
  @override
  Future<Inspection> insertFutureInspection(Inspection inspection) async {
    Database db = await this.databeses;
    inspection.id = await db.insert(futureInspectionTable, inspection.toMap(), nullColumnHack: columnId);
    print('add');
    return inspection;
  }

  /// INSERT User
  @override
  Future<User> insertUser(User user) async {
    Database db = await this.databeses;
    user.id = await db.insert(userTable, user.toMap(), nullColumnHack: columnId);
    print('add');
    return user;
  }

  /// UPDATE
  @override
  Future<int> updateInspection(Inspection inspection) async {
    Database db = await this.databeses;
    return await db.update(inspectionTable, inspection.toMap(),
        where: '$columnId = ?', whereArgs: [inspection.id]);
  }

  /// UPDATE FUTURE
  @override
  Future<int> updateFutureInspection(Inspection inspection) async {
    Database db = await this.databeses;
    return await db.update(futureInspectionTable, inspection.toMap(),
        where: '$columnId = ?', whereArgs: [inspection.id]);
  }

  /// UPDATE User
  @override
  Future<int> updateUser(User user) async {
    Database db = await this.databeses;
    return await db.update(userTable, user.toMap(),
        where: '$columnId = ?', whereArgs: [user.id]);
  }

  /// DELETE
  @override
  Future<int> deleteInspection(int id) async {
    Database db = await this.databeses;
    return await db.delete(
      inspectionTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  /// DELETE FUTURE
  @override
  Future<int> deleteFutureInspection(int id) async {
    Database db = await this.databeses;
    return await db.delete(
      futureInspectionTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  /// DELETE User
  @override
  Future<int> deleteUser(int id) async {
    Database db = await this.databeses;
    return await db.delete(
      userTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
