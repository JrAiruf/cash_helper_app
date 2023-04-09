import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/operator_module/infra/models/operator_model.dart';

import '../../external/data/application_login_database.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({required ApplicationLoginDatabase datasource})
      : _datasource = datasource;
  final ApplicationLoginDatabase _datasource;

  @override
  Future<OperatorModel?>? register(OperatorModel? newOperator, String? collection) async {
    if (newOperator != null && collection !=null) {
      final databaseOperator = await _datasource.register(newOperator.toMap(), collection);
      return OperatorModel.fromMap(databaseOperator ?? {});
    } else {
      return null;
    }
  }

  @override
  Future<OperatorModel?>? login(
      String? email, String? password, String? collection) async {
   if (email != null && password !=null) {
      final databaseOperator = await _datasource.login(email, password, collection);
      return OperatorModel.fromMap(databaseOperator ?? {});
    } else {
      return null;
    }
  }

  @override
  Future<OperatorModel?>? getOperatorById(
      String? operatorId, String? collection) async {
if (operatorId != null && collection != null) {
  final databaseOperator = await _datasource.getOperatorById(operatorId, collection);
  return OperatorModel.fromMap(databaseOperator ?? {});
} else {
  return null;
}
  }

  @override
  Future<bool>? checkOperatorDataForResetPassword(
      String? email, int? cashierNumber, String? collection) async {
        if(email!.isNotEmpty && collection!.isNotEmpty){
          return await _datasource.checkOperatorDataForResetPassword(email, cashierNumber, collection)!;
        } else {
        return false;
        }
  }

  @override
  Future<void>? resetOperatorPassword(String? email, int? cashierNumber, String? newPassword) async {
    if(email!.isNotEmpty && !cashierNumber!.isNaN && newPassword!.isNotEmpty){
      await _datasource.resetOperatorPassword(email, cashierNumber, newPassword);
    } else {
      return;
    }
  }

  @override
  Future<void>? signOut() async {
    await _datasource.signOut();
  }
}