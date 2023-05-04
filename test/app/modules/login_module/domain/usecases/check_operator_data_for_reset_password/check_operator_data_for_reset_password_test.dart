import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/check_operator_data_for_reset_password/icheck_operator_data_for_reset_password.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import '../register_operator/register_operator_test.dart';

class CheckOpDataMock implements ICheckOperatorDataForResetPassword {
CheckOpDataMock({required LoginRepository repository})
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

void main() {
  final repository = LoginRepositoryMock();
  final register = RegisterOperatorUsecaseMock(repository: repository);
  final checkOperatorDataForResetPassword = CheckOpDataMock(repository: repository);
  final newOperator = OperatorEntity(
    operatorId: 'q34u6hu1qeuyoio',
    operatorNumber: 1,
    operatorName: ' Josy Kelly',
    operatorEmail: 'josy@email.com',
    operatorPassword: '12345678',
    operatorOppening: 'operatorOppening',
    operatorClosing: 'operatorClosing',
    operatorEnabled: false,
    businessPosition: "operator",
  );/* 
 group(
    "CheckOperatorDataForResetPassword function should",
    () {
      test(
        "Call repository function to check opertor's informations",
       () async {

          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
          final checkedInformation = await checkOperatorDataForResetPassword(createdOperator?.operatorEmail, createdOperator?.operatorCode,"collection");
          expect(checkedInformation, equals(true));
          
        },
      );
      test(
        "Return false for non checked informations",
        () async {
        when(repository.register(any, any)).thenAnswer((_) async => repositoryOperator);
          when(repository.checkOperatorDataForResetPassword(any, any,any)).thenAnswer((_) async => false);
          final createdOperator = await register(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
          final checkedInformation = await checkOperatorDataForResetPassword(createdOperator?.operatorEmail, createdOperator?.operatorCode,"");
          expect(checkedInformation, equals(null));
        },
      );
    },
  ); */
}