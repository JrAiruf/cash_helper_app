import 'package:cash_helper_app/app/modules/user_module/external/data/operator_database.dart';

import '../data/operator_repository.dart';

class OperatorRepositoryImpl implements OperatorRepository {
  OperatorRepositoryImpl({required OperatorDatabase database})
      : _database = database;

  final OperatorDatabase _database;
  @override
  Future<void> changeOperatorEmail(String? newEmail, String? operatorCode,
      String? operatorPassword, String? collection) async {
    if (_validOperatorData(newEmail, operatorCode, operatorPassword)) {
      return await _database.changeUserEmail(
          newEmail, operatorCode, operatorPassword, collection);
    } else {
      return;
    }
  }

  @override
  Future<void> deleteOperatorAccount(String? operatorCode, String? newEmail,
      String? operatorPassword, String? collection) async {
    if (_validOperatorData(newEmail, operatorCode, operatorPassword)) {
      return await _database.deleteUserAccount(
          operatorCode, newEmail, operatorPassword, collection);
    } else {
      return;
    }
  }

  @override
  Future? changeOperatorPassword(String? newPassword, String? operatorCode,
      String? currentPassword, String? collection) async {
    if (_validOperatorData(newPassword, operatorCode, currentPassword)) {
      return await _database.changeUserPassword(
          newPassword, operatorCode, currentPassword, collection);
    } else {
      return;
    }
  }

  @override
  Future<void>? openOperatorCash(
      String? operatorId, String? collection, String? oppeningTime) async {
    if (_validOperatorData(operatorId, collection, oppeningTime)) {
      await _database.openOperatorCash(operatorId, collection, oppeningTime);
    } else {
      return;
    }
  }

  @override
  Future<void>? closeOperatorCash(
      String? operatorId, String? collection, String? closingTime) async {
    if (_validOperatorData(operatorId, collection, closingTime)) {
      await _database.closeOperatorCash(operatorId, collection, closingTime);
    } else {
      return;
    }
  }

  bool _validOperatorData(
          String? newEmail, String? operatorCode, String? operatorPassword) =>
      newEmail!.isNotEmpty &&
      operatorCode!.isNotEmpty &&
      operatorPassword!.isNotEmpty;
}
