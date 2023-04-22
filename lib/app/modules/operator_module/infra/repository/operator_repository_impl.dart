import 'package:cash_helper_app/app/modules/operator_module/external/data/operator_database.dart';

import '../data/operator_repository.dart';

class OperatorRepositoryImpl implements OperatorRepository {
  OperatorRepositoryImpl({required OperatorDatabase database}) : _database = database;

  final OperatorDatabase _database;
  @override
  Future<void> changeOperatorEmail(
      String? newEmail, String? operatorCode, String? operatorPassword,String? collection) async {
        if (_validOperatorData(newEmail, operatorCode, operatorPassword)) {
    return await _database.changeOperatorEmail(newEmail, operatorCode, operatorPassword, collection);
        } else {
          return;
        }
  }

  @override
  Future<void> deleteOperatorAccount(
      String? operatorCode, String? newEmail, String? operatorPassword,String? collection) async {
        if (_validOperatorData(newEmail, operatorCode, operatorPassword)) {
     return await _database.deleteOperatorAccount(operatorCode, newEmail, operatorPassword, collection);
        } else {
          return;
        }
  }
   bool _validOperatorData(
          String? newEmail, String? operatorCode, String? operatorPassword) =>
      newEmail!.isNotEmpty && operatorCode!.isNotEmpty && operatorPassword!.isNotEmpty;
      
        @override
        Future? changeOperatorPassword(String? newPassword, String? operatorCode, String? currentPassword, String? collection) {
          // TODO: implement changeOperatorPassword
          throw UnimplementedError();
        }
}
