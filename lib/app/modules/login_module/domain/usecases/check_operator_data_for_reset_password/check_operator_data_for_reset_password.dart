import 'package:cash_helper_app/app/modules/login_module/domain/usecases/check_operator_data_for_reset_password/icheck_operator_data_for_reset_password.dart';
import '../../../../../helpers/data_verifier.dart';
import '../../../infra/data/login_repository.dart';

class CheckOperatorDataForResetPassword implements ICheckOperatorDataForResetPassword {
CheckOperatorDataForResetPassword({required LoginRepository repository})
      : _repository = repository;

  final LoginRepository _repository;
  final _dataVerifier = DataVerifier();
  @override
  Future<bool?> call(String? email, String? operatorCode, String? collection) async {
   return _dataVerifier.validateInputData(inputs: [email, operatorCode, collection]) ?
      await _repository.checkOperatorDataForResetPassword(email, operatorCode, collection)
    : null;
    
  }
}
