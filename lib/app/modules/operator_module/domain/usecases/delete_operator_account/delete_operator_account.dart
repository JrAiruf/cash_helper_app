import 'package:cash_helper_app/app/modules/operator_module/domain/usecases/delete_operator_account/idelete_operator_account.dart';

import '../../../infra/data/operator_repository.dart';

class DeleteOperatorAccount implements IDeleteOperatorAccount {
 DeleteOperatorAccount({required OperatorRepository repository})
      : _repository = repository;
  final OperatorRepository _repository;
  @override
  Future call(String? operatorCode, String? operatorEmail, String? operatorPassword, String? collection) async {
    if(_validOperatorData(operatorEmail, operatorCode, operatorPassword)){
      print("Cheguei");
      await _repository.deleteOperatorAccount(operatorCode, operatorEmail, operatorPassword, collection);
    } else {
      return;
    }
  }

   bool _validOperatorData(
          String? newEmail, String? operatorCode, String? operatorPassword) =>
      newEmail != null && operatorCode != null && operatorPassword != null;

}