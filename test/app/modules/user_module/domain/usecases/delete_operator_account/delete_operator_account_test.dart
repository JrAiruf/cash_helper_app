import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/usecases/delete_operator_account/idelete_operator_account.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/data/operator_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import '../../../../login_module/domain/usecases/get_operator_by_id/get_operator_by_id_test.dart';
import '../../../../login_module/domain/usecases/register_operator/register_operator_test.dart';

class OperatorRepositoryMock extends Mock implements OperatorRepository {}

class DeleteOperatorAccountUsecaseMock implements IDeleteOperatorAccount {
  DeleteOperatorAccountUsecaseMock({required OperatorRepository repository})
      : _repository = repository;
  final OperatorRepository _repository;

  @override
  Future<void> call(String? operatorCode, String? operatorEmail,
      String? operatorPassword, String? collection) async {
    if (_validOperatorData(operatorEmail, operatorCode, operatorPassword)) {
      await _repository.deleteOperatorAccount(
          operatorCode, operatorEmail, operatorPassword, collection);
    } else {
      return;
    }
  }

  bool _validOperatorData(String? operatorEmail, String? operatorCode,
          String? operatorPassword) =>
      operatorEmail != null && operatorCode != null && operatorPassword != null;
}

void main() {
  final loginRepository = LoginRepositoryMock();
  final register = RegisterOperatorUsecaseMock(repository: loginRepository);
  final getOperatorById = GetOperatorByIdMock(repository: loginRepository);
  final operatorRepository = OperatorRepositoryMock();
  final deleteOperatorAccount =
      DeleteOperatorAccountUsecaseMock(repository: operatorRepository);
  final newOperator = OperatorEntity(
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
/*   group(
    "DeleteOperatorAccount function should",
    () {
      test(
        'Call repository to delete operator account',
        () async {
          when(loginRepository.register(any, any))
              .thenAnswer((_) async => repositoryOperator);
          when(loginRepository.getOperatorById(any, any))
              .thenAnswer((_) async => null);
          final createdOperator = await register(
              newOperator, newOperator.businessPosition);
          expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorRepository.deleteOperatorAccount(any, any, any, any))
              .thenReturn(null);
          await deleteOperatorAccount(
              "newPassword",
              createdOperator?.operatorCode,
              createdOperator?.operatorPassword,
              "collection");
          final currenteOperator =
              await getOperatorById("operatorId", "collection");
          expect(currenteOperator?.operatorId, equals(null));
        },
      );
      test(
        'Fail in deleting operator account',
        () async {
          when(loginRepository.register(any, any))
              .thenAnswer((_) async => repositoryOperator);
          when(loginRepository.getOperatorById(any, any))
              .thenAnswer((_) async => repositoryOperator);
          final createdOperator = await register(
              newOperator, newOperator.businessPosition);
          expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorRepository.deleteOperatorAccount(any, any, any, any))
              .thenReturn(null);
          await deleteOperatorAccount(
              "newPassword",
              createdOperator?.operatorCode,
              createdOperator?.operatorPassword,
              null);
          final currenteOperator =
              await getOperatorById("operatorId", "collection");
          expect(currenteOperator?.operatorCode, equals("123456"));
        },
      );
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

final modifiedRepositoryOperator = OperatorModel(
  operatorId: 'q34u6hu1qeuyoio',
  operatorNumber: 1,
  operatorName: 'Josy Kelly',
  operatorEmail: 'josy_kelly@email.com',
  operatorPassword: 'newPassword',
  operatorCode: 'newPas',
  operatorOppening: 'operatorOppening',
  operatorClosing: 'operatorClosing',
  operatorEnabled: false,
  businessPosition: "operator",
);
