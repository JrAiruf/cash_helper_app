// ignore_for_file: unused_import, unused_local_variable

import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/check_operator_data_for_reset_password/icheck_user_data_for_reset_password.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import '../register_operator/register_operator_test.dart';

class CheckOpDataMock implements ICheckUserDataForResetPassword {
  CheckOpDataMock({required LoginRepository repository}) : _repository = repository;

  final LoginRepository _repository;
  final _dataVerifier = DataVerifier();

  @override
  Future<bool> call(String enterpriseId, String userEmail, String userrCode, String collection) async {
    return await _repository.checkUserDataForResetPassword(enterpriseId, userEmail, userrCode, collection)!;
  }
}

void main() {
  final repository = LoginRepositoryMock();
  final register = RegisterOperatorUsecaseMock(repository: repository);
  final checkOperatorDataForResetPassword = CheckOpDataMock(repository: repository);
  group(
    "CheckUserDataForResetPassword function should",
    () {
      test(
        "Call repository function to check opertor's informations",
        () async {
          when(repository.checkUserDataForResetPassword(any, any, any, any)).thenAnswer((_) async => true);
          final checkedInformation = await checkOperatorDataForResetPassword("enterpriseId", "userEmail", "userPassword", "collection");
          expect(checkedInformation, equals(true));
        },
      );
      test(
        "Return false for non checked informations",
        () async {
          when(repository.checkUserDataForResetPassword(any, any, any, any)).thenAnswer((_) async => false);
          final checkedInformation = await checkOperatorDataForResetPassword("enterpriseId", "userEmail", "userPassword", "collection");
          expect(checkedInformation, equals(false));
        },
      );
    },
  );
}
