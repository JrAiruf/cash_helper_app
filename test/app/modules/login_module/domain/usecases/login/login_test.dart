import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/login/ilogin.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import '../register_operator/register_operator_test.dart';

class LoginUsecaseMock implements ILogin {
  LoginUsecaseMock({required LoginRepository repository})
      : _repository = repository;

  final LoginRepository _repository;
  final _dataVerifier = DataVerifier();

  @override
  Future<OperatorEntity?> call(String? email, String? password, String? collection) async {
 if(_dataVerifier.validateInputData(inputs: [email,password,collection])){
   final operatorModel = await _repository.login(email, password, collection);
      return OperatorModel.toEntityData(operatorModel ?? OperatorModel());
 } else {
  return null;
 }
  }
}

void main() {
  final repository = LoginRepositoryMock();
  final register = RegisterOperatorUsecaseMock(repository: repository);
  final login = LoginUsecaseMock(repository: repository);
  final newOperator = OperatorEntity(
    operatorId: 'q34u6hu1qeuyoio',
    operatorNumber: 1,
    operatorName: ' Josy Kelly',
    operatorEmail: 'josy@email.com',
    operatorPassword: '12345678',
    operatorOppening: 'operatorOppening',
    operatorClosing: 'operatorClosing',
    operatorEnabled: false,
    operatorOcupation: "operator",
  );
  group(
    "Login function should",
    () {
      test(
        "Call repository function to signIn",
        () async {
          when(repository.register(any, any))
              .thenAnswer((_) async => repositoryOperator);
          when(repository.login(any, any, any))
              .thenAnswer((_) async => repositoryOperator);
          final createdOperator = await register(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
          final loginOperator = await login(
              createdOperator?.operatorEmail,
              createdOperator?.operatorPassword,
              createdOperator?.operatorOcupation.toString());
          expect(loginOperator, isA<OperatorEntity>());
          expect(loginOperator?.operatorId != null, equals(true));
        },
      );
      test(
        "Fail to sign In",
        () async {
          when(repository.register(any, any))
              .thenAnswer((_) async => repositoryOperator);
          when(repository.login(any, any, any)).thenAnswer((_) async => null);
          final createdOperator = await register(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
          final loginOperator = await login(null, "", "");
          expect(loginOperator, equals(null));
        },
      );
    },
  );
}

final repositoryOperator = OperatorModel(
  operatorId: 'q34u6hu1qeuyoio',
  operatorNumber: 1,
  operatorName: 'Josy Kelly',
  operatorEmail: 'josy@email.com',
  operatorPassword: '12345678',
  operatorCode: '123456',
  operatorOppening: 'operatorOppening',
  operatorClosing: 'operatorClosing',
  operatorEnabled: false,
  operatorOcupation: "operator",
);
