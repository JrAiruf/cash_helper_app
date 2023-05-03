import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/usecases/change_operator_password/ichange_operator_password.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/data/operator_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import '../../../../login_module/domain/usecases/get_operator_by_id/get_operator_by_id_test.dart';
import '../../../../login_module/domain/usecases/register_operator/register_operator_test.dart';

class OperatorRepositoryMock extends Mock implements OperatorRepository {}

class ChangeOperatorPasswordUsecaseMock implements IChangeOperatorPassword {
ChangeOperatorPasswordUsecaseMock({required OperatorRepository repository})
      : _repository = repository;
      
  final OperatorRepository _repository;
@override
  Future call(String? newPassword, String? operatorCode, String? currentPassword, String? collection) async {
   if(_validOperatorData(newPassword, operatorCode, currentPassword)){
    _repository.changeOperatorPassword(newPassword, operatorCode, currentPassword, collection);
   } else {
    return;
   }
  }

   bool _validOperatorData(
          String? newEmail, String? operatorCode, String? operatorPassword) =>
      newEmail != null && operatorCode != null && operatorPassword != null;
}

void main() {
 final loginRepository = LoginRepositoryMock();
  final register = RegisterOperatorUsecaseMock(repository: loginRepository);
  final getOperatorById = GetOperatorByIdMock(repository: loginRepository);
  final operatorRepository = OperatorRepositoryMock();
  final changeOperatorPassword = ChangeOperatorPasswordUsecaseMock(repository: operatorRepository);
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
  group(
    "ChangeOperatorPassword function should",
    () {
      test(
        'Call repository to change operator password',
        () async {
          when(loginRepository.register(any, any))
              .thenAnswer((_) async => repositoryOperator);
          when(loginRepository.getOperatorById(any, any))
              .thenAnswer((_) async => modifiedRepositoryOperator);
          final createdOperator = await register(
              newOperator, newOperator.businessPosition);
          expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorRepository.changeOperatorPassword(any, any, any, any))
              .thenReturn(null);
          await changeOperatorPassword(
              "newPassword",
              createdOperator?.operatorCode,
              createdOperator?.operatorPassword,
              null);
          final currenteOperator =
              await getOperatorById("operatorId", "collection");
          expect(
              currenteOperator?.operatorPassword, equals("newPassword"));
        },
      );
      test(
        'Fail in changing operator password',
        () async {
          when(loginRepository.register(any, any))
              .thenAnswer((_) async => repositoryOperator);
          when(loginRepository.getOperatorById(any, any))
              .thenAnswer((_) async => repositoryOperator);
          final createdOperator = await register(
              newOperator, newOperator.businessPosition);
          expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorRepository.changeOperatorPassword(any, any, any, any))
              .thenReturn(null);
          await changeOperatorPassword(null, createdOperator?.operatorCode,createdOperator?.operatorPassword, null);
          final currenteOperator =
              await getOperatorById("operatorId", "collection");
          expect(currenteOperator?.operatorPassword, equals("12345678"));
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