import 'package:cash_helper_app/app/modules/operator_module/domain/contract/operator_usecases.dart';
import 'package:cash_helper_app/app/modules/operator_module/infra/data/operator_repository.dart';

class OperatorUsecasesImpl implements OperatorUsecases {
  OperatorUsecasesImpl({required OperatorRepository repository})
      : _repository = repository;

  final OperatorRepository _repository;
  @override
  Future<void> changeOperatorEmail(String? newEmail, String? operatorCode,
      String? operatorPassword, String? collection) async {
    if (_validOperatorData(newEmail, operatorCode, operatorPassword)) {
      return await _repository.changeOperatorEmail(
          newEmail, operatorCode, operatorPassword, collection);
    } else {
      return;
    }
  }

  @override
  Future<void> deleteOperatorAccount(String? operatorCode, String? newEmail,
      String? operatorPassword, String? collection) async {
    if (_validOperatorData(newEmail, operatorCode, operatorPassword)) {
      return await _repository.deleteOperatorAccount(
          operatorCode, newEmail, operatorPassword, collection);
    } else {
      return;
    }
  }

  @override
  Future? changeOperatorPassword(String? newPassword, String? operatorCode,
      String? currentPassword, String? collection) async {
    if (_validOperatorData(newPassword, operatorCode, currentPassword)) {
      return await _repository.changeOperatorPassword(
          newPassword, operatorCode, currentPassword, collection);
    } else {
      return;
    }
  }

  bool _validOperatorData(
          String? newEmail, String? operatorCode, String? operatorPassword) =>
      newEmail != null && operatorCode != null && operatorPassword != null;
}
