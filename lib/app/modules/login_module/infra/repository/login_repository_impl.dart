import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';

import '../../external/data/application_login_database.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({required ApplicationLoginDatabase datasource})
      : _datasource = datasource;
  final ApplicationLoginDatabase _datasource;

  @override
  Future<OperatorModel?>? register(OperatorModel? newOperator,String? enterpriseId, String? collection) async {
    if (newOperator != null && collection !=null) {
      final databaseOperator = await _datasource.register(newOperator.toMap(),"", collection);
      return OperatorModel.fromMap(databaseOperator ?? {});
    } else {
      return null;
    }
  }

  @override
  Future<OperatorModel?>? login(
      String? email, String? password, String? enterpriseId,String? collection) async {
   if (email != null && password !=null) {
      final databaseOperator = await _datasource.login(email, password,"", collection);
      return OperatorModel.fromMap(databaseOperator ?? {});
    } else {
      return null;
    }
  }

  @override
  Future<OperatorModel?>? getOperatorById(
      String? operatorId, String? collection) async {
if (operatorId != null && collection != null) {
  final databaseOperator = await _datasource.getUserById(operatorId,"", collection);
  return OperatorModel.fromMap(databaseOperator ?? {});
} else {
  return null;
}
  }

  @override
  Future<bool>? checkOperatorDataForResetPassword(
      String? email, String? operatorCode, String? collection) async {
        if(email!.isNotEmpty && collection!.isNotEmpty){
          return await _datasource.checkOperatorDataForResetPassword(email, operatorCode,"", collection)!;
        } else {
        return false;
        }
  }

  @override
  Future<void>? resetOperatorPassword(String? email, String? operatorCode, String? newPassword) async {
    if(email!.isNotEmpty && operatorCode!.isNotEmpty && newPassword!.isNotEmpty){
  return await _datasource.resetOperatorPassword(email, operatorCode,"", newPassword);
    } else {
      return;
    }
  }

  @override
  Future<void>? signOut() async {
    await _datasource.signOut();
  }
}