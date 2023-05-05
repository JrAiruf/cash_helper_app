import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';

import '../../../../helpers/data_verifier.dart';
import '../../../user_module/infra/models/manager_model.dart';
import '../../external/data/application_login_database.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({
    required ApplicationLoginDatabase datasource,
    required DataVerifier dataVerifier,
  })  : _datasource = datasource,
        _dataVerifier = dataVerifier;
  final ApplicationLoginDatabase _datasource;
  final DataVerifier _dataVerifier;

  @override
  Future<dynamic>? register(
      dynamic newUser, String? enterpriseId, String? collection) async {
    if (_dataVerifier.objectVerifier(object: newUser?.toMap() ?? {}) &&
        _dataVerifier.validateInputData(inputs: [enterpriseId, collection])) {
      if (_dataVerifier.operatorModelVerifier(model: newUser)) {
        final opertatorMap = await _datasource.register(
            newUser.toMap(), enterpriseId, collection);
        return OperatorModel.fromMap(opertatorMap);
      } else if (_dataVerifier.managerModelVerifier(model: newUser)) {
        final managerMap = await _datasource.register(
            newUser.toMap(), enterpriseId, collection);
        return ManagerModel.fromMap(managerMap);
      }
    } else {
      return null;
    }
  }

  @override
  Future<dynamic>? login(String? email, String? password, String? enterpriseId,
      String? collection) async {
    if (_dataVerifier.validateInputData(
        inputs: [email, password, enterpriseId, collection])) {
      final databaseMap =
          await _datasource.login(email, password, enterpriseId, collection);
      if (_dataVerifier.operatorMapVerifier(map: databaseMap)) {
        return OperatorModel.fromMap(databaseMap);
      } else if (_dataVerifier.managerMapVerifier(map: databaseMap)) {
        return ManagerModel.fromMap(databaseMap);
      }
    } else {
      return null;
    }
  }

  @override
  Future<dynamic>? getUserById(
      String? enterpriseId, String? operatorId, String? collection) async {
    if (_dataVerifier
        .validateInputData(inputs: [enterpriseId, operatorId, collection])) {
       final databaseMap = await _datasource.getUserById(enterpriseId, operatorId, collection);
       if (_dataVerifier.operatorMapVerifier(map: databaseMap ?? {})) {
           return OperatorModel.fromMap(databaseMap);
       } else if (_dataVerifier.managerMapVerifier(map: databaseMap ?? {})) {
        return ManagerModel.fromMap(databaseMap);
      }
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