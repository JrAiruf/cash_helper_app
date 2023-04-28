import 'package:cash_helper_app/app/modules/operator_module/domain/usecases/change_operator_password/ichange_operator_password.dart';
import '../../../infra/data/operator_repository.dart';

class ChangeOperatorPassword implements IChangeOperatorPassword{
   ChangeOperatorPassword({required OperatorRepository repository})
      : _repository = repository;
  final OperatorRepository _repository;
  @override
  Future call(String? newPassword, String? operatorCode, String? currentPassword, String? collection) async {
   if(_validOperatorData(newPassword, operatorCode, currentPassword)){
    _repository.changeOperatorPassword(newPassword, operatorCode, currentPassword, collection);
   } else {
    return;
   }
  }

   bool _validOperatorData(
          String? newEmail, String? operatorCode, String? operatorPassword) =>
      newEmail != null && operatorCode != null && operatorPassword != null;
}