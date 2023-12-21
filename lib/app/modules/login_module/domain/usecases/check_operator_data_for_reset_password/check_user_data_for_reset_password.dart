import 'package:cash_helper_app/app/modules/login_module/domain/usecases/check_operator_data_for_reset_password/icheck_user_data_for_reset_password.dart';
import '../../../infra/data/login_repository.dart';

class CheckUserDataForResetPassword implements ICheckUserDataForResetPassword {
CheckUserDataForResetPassword({required LoginRepository repository}) : _repository = repository;

  final LoginRepository _repository;

  @override
  Future<bool> call(String enterpriseId, String userEmail, String userrCode, String collection) async =>
      await _repository.checkUserDataForResetPassword(enterpriseId, userEmail, userrCode, collection) ?? false;

}
