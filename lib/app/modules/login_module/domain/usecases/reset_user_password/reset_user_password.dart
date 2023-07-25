import 'package:cash_helper_app/app/modules/login_module/domain/usecases/reset_user_password/ireset_user_password.dart';

import '../../../../../helpers/data_verifier.dart';
import '../../../infra/data/login_repository.dart';

class ResetOperatorPassword implements IResetOperatorPassword {
ResetOperatorPassword({required LoginRepository repository})
      : _repository = repository;

  final LoginRepository _repository;
  final _dataVerifier = DataVerifier();
  @override
  Future call(String? email, String? operatorCode, String? newPassword) async {
    return _dataVerifier.validateInputData(inputs: [email, operatorCode, newPassword])
        ? _repository.resetUserPassword(email, operatorCode, newPassword)
        : null;
  }
}