
import 'package:carhelper/data/model/Inspection.dart';
import 'package:carhelper/data/model/User.dart';

abstract class SQLDataService {
  ///READ OLD
  Future<List<Inspection>> getInspection();

  ///READ FUTURE
  Future<List<Inspection>> getFutureInspection();

  ///READ User
  Future<List<User>> getUser();

  /// INSERT
  Future<Inspection> insertInspection(Inspection inspection);

  /// INSERT FUTURE
  Future<Inspection> insertFutureInspection(Inspection inspection);

  /// INSERT User
  Future<User> insertUser(User user);

  /// UPDATE
  Future<int> updateInspection(Inspection inspection);

  /// UPDATE FUTURE
  Future<int> updateFutureInspection(Inspection inspection);

  /// UPDATE User
  Future<int> updateUser(User user);

  /// DELETE
  Future<int> deleteInspection(int id);

  /// DELETE FUTURE
  Future<int> deleteFutureInspection(int id);

  /// DELETE User
  Future<int> deleteUser(int id);
}