import '../../../infra/data/operator_repository.dart';
import 'ichange_operator_email.dart';

class ChangeOperatorEmail implements IChangeOperatorEmail {
 ChangeOperatorEmail({required OperatorRepository repository})
      : _repository = repository;
  final OperatorRepository _repository;

  @override
  Future call(String? newEmail, String? operatorCode, String? operatorPassword,
      String? collection) async {
    if (_validOperatorData(newEmail, operatorCode, operatorPassword)) {
      await _repository.changeOperatorEmail(
          newEmail, operatorCode, operatorPassword, collection);
    } else {
      return;
    }
  }

  bool _validOperatorData(
          String? newEmail, String? operatorCode, String? operatorPassword) =>
      newEmail != null && operatorCode != null && operatorPassword != null;
}
