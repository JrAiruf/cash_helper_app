import 'package:cash_helper_app/app/modules/login_module/domain/usecases/sign_out/isign_out.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import '../get_operator_by_id/get_operator_by_id_test.dart';
import '../login/login_test.dart';
import '../register_operator/register_operator_test.dart';

class SignOutMock implements ISignOut {
  SignOutMock({required LoginRepository repository}) : _repository = repository;

  final LoginRepository _repository;

  @override
  Future<void> call() async {
    await _repository.signOut();
  }
}

void main() {
  final repository = LoginRepositoryMock();
  final register = RegisterOperatorUsecaseMock(repository: repository);
  final getOperatorById = GetOperatorByIdMock(repository: repository);
  final signOut = SignOutMock(repository: repository);

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
  test(
    "Should sign out the application",
    () async {
      when(repository.register(any, any))
          .thenAnswer((_) async => repositoryOperator);
      when(repository.login(any, any, any))
          .thenAnswer((_) async => repositoryOperator);
      when(repository.signOut()).thenReturn(null);
      when(repository.getOperatorById(any, any)).thenAnswer((_) async => null);
      final createdOperator = await register(newOperator, "collection");
      expect(createdOperator, isA<OperatorEntity>());
      expect(createdOperator?.operatorId != null, equals(true));
      final loginOperator = await login(
          createdOperator?.operatorEmail,
          createdOperator?.operatorPassword,
          createdOperator?.businessPosition.toString());
      expect(loginOperator, isA<OperatorEntity>());
      expect(loginOperator?.operatorId != null, equals(true));
      await signOut();
      final loggedOffOperator = await getOperatorById("id", "collection");
      expect(loggedOffOperator?.operatorId, equals(null));
    },
  ); */
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
  businessPosition: "operator",
);
