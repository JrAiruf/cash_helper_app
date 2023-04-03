import 'package:cash_helper_app/app/modules/login_module/domain/contract/login_usecases.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';

import '../../../operator_module/infra/models/operator_model.dart';
import '../../infra/data/login_repository.dart';

class LoginUsecasesImpl implements LoginUsecases {
 LoginUsecasesImpl(LoginRepository repository) : _repository = repository;

  final LoginRepository _repository;
  @override
  Future<OperatorEntity?>? register(
      OperatorEntity? newOperator, String? collection) async {
    if (newOperator != null && collection != null) {
      final operatorModelData = OperatorModel.fromEntityData(newOperator);
      final operatorModel = await _repository.register(operatorModelData, collection);
      return OperatorModel.toEntityData(operatorModel ?? OperatorModel());
    } else {
      return null;
    }
  }

  @override
  Future<OperatorEntity?>? login(
      String? email, String? password, String? collection) async {
  if(email != null && password != null && collection != null) {
      final operatorModel = await _repository.login(email, password, collection);
      return OperatorModel.toEntityData(operatorModel ?? OperatorModel());
  } else {
    return null;
  }
}

  @override
  Future<OperatorEntity?>? getOperatorById(
      String? operatorId, String? collection) async {
    if (operatorId != null && collection != null) {
        final operatorModel = await _repository.getOperatorById(operatorId, collection);
        return OperatorModel.toEntityData(operatorModel ?? OperatorModel());
    } else {
      return null;
    }
  }

  @override
  Future<bool>? checkOperatorDataForResetPassword(
      String? email, int? cashierNumber, String? collection) async {
    // TODO: implement checkOperatorDataForResetPassword
    throw UnimplementedError();
  }

  @override
  Future<void>? resetOperatorPassword(String? email, int? cashierNumber,
      String? collection, String? newPassword) {
    // TODO: implement resetOperatorPassword
    throw UnimplementedError();
  }

  @override
  Future<void>? signOut() async {
  await _repository.signOut();
  }
}
