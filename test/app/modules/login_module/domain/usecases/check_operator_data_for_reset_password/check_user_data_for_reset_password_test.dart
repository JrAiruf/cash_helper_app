import 'package:cash_helper_app/app/modules/login_module/domain/usecases/check_operator_data_for_reset_password/icheck_user_data_for_reset_password.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';

class CheckUserDataForResetPasswordMock implements ICheckUserDataForResetPassword {
  CheckUserDataForResetPasswordMock({required LoginRepository repository}) : _repository = repository;

  final LoginRepository _repository;

  @override
  Future<bool> call(String enterpriseId, String userEmail, String userrCode, String collection) async =>
      await _repository.checkUserDataForResetPassword(enterpriseId, userEmail, userrCode, collection) ?? false;
}

void main() {
  final repository = LoginRepositoryMock();
  final checkUsecase = CheckUserDataForResetPasswordMock(repository: repository);
  test("CheckUserDataForResetPassword should return true if data is right", () async {
    when(repository.checkUserDataForResetPassword(any, any, any, any)).thenAnswer((_) async => true);
    final result = await checkUsecase("enterpriseId", "userEmail", "userCode", "businessPosition");
    expect(result, equals(true));
  });
}
