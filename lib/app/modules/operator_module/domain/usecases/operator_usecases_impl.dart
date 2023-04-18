import 'package:cash_helper_app/app/modules/operator_module/domain/contract/operator_usecases.dart';
import 'package:cash_helper_app/app/modules/operator_module/infra/data/operator_repository.dart';

class OperatorUsecasesImpl implements OperatorUsecases {
  OperatorUsecasesImpl({required OperatorRepository repository}) : _repository = repository;

  final OperatorRepository _repository;
  @override
  Future changeOperatorEmail(String? newEmail, String? operatorCode,
      String? operatorPassword, String? collection) {
    // TODO: implement changeOperatorEmail
    throw UnimplementedError();
  }

  @override
  Future deleteOperatorAccount(String? operatorCode, String? newEmail,
      String? operatorPassword, String? collection) {
    // TODO: implement deleteOperatorAccount
    throw UnimplementedError();
  }
}
