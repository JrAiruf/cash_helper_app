import 'package:cash_helper_app/app/modules/operator_module/domain/contract/operator_usecases.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/operator_module/infra/data/operator_repository.dart';
import 'package:cash_helper_app/app/modules/operator_module/infra/models/operator_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../login_module/domain/usecases/login_usecases_impl_test.dart';
class OperatorRepositoryMock extends Mock implements OperatorRepository {}
class OperatorUsecasesMock implements OperatorUsecases {
OperatorUsecasesMock({required OperatorRepository repository}) : _repository = repository;

  final OperatorRepository _repository;
  @override
  Future<void> changeOperatorEmail(String? newEmail, String? operatorCode, String? operatorPassword, String? collection) async {
   if (_validOperatorData(newEmail, operatorCode, operatorPassword)) {
     return await _repository.changeOperatorEmail(newEmail, operatorCode, operatorPassword, collection);
   } else {
    return;
   }
  }

  @override
  Future<void> deleteOperatorAccount(String? operatorCode, String? newEmail, String? operatorPassword, String? collection) async {
   if (_validOperatorData(newEmail, operatorCode, operatorPassword)) {
     return await _repository.deleteOperatorAccount(operatorCode, newEmail, operatorPassword, collection);
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
  final loginUsecases = LoginUsecasesMock(repository: loginRepository);
  final operatorRepository = OperatorRepositoryMock();
  final operatorUsecases = OperatorUsecasesMock(repository: operatorRepository);
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
    operatorOcupation: "operator",
  );
  
  group(
    'ChangeOperatorEmail function should',
    () {
      test(
        'Call repository function to change operator e-mail',
        () async {
           when(loginRepository.register(any, any)).thenAnswer((_) async => repositoryOperator);
          when(loginRepository.getOperatorById(any, any)).thenAnswer((_) async => modifiedRepositoryOperator);
          final createdOperator = await loginUsecases.register(
              newOperator, newOperator.operatorOcupation);
              expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorRepository.changeOperatorEmail(any, any, any, any)).thenReturn(null);
          await operatorUsecases.changeOperatorEmail("josy_kelly@email.com", createdOperator?.operatorCode, createdOperator?.operatorPassword,null);
        final currenteOperator = await loginUsecases.getOperatorById("operatorId", "collection");
        expect(currenteOperator?.operatorEmail, equals("josy_kelly@email.com"));
        },
      );
      test(
        'Fail to change e-mail',
        () async {
            when(loginRepository.register(any, any)).thenAnswer((_) async => repositoryOperator);
          when(loginRepository.getOperatorById(any, any)).thenAnswer((_) async => repositoryOperator);
          final createdOperator = await loginUsecases.register(
              newOperator, newOperator.operatorOcupation);
              expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorRepository.changeOperatorEmail(any, any, any, any)).thenReturn(null);
          await operatorUsecases.changeOperatorEmail("josy_kelly@email.com", null, createdOperator?.operatorPassword,null);
        final currenteOperator = await loginUsecases.getOperatorById("operatorId", "collection");
        expect(currenteOperator?.operatorEmail, equals("josy@email.com"));
        },
      );
    },
  );
  group(
    'DeleteOperatorAccount function should',
    () {
      test(
        'Call repository to delete operator account',
        () async {
  when(loginRepository.register(any, any)).thenAnswer((_) async => repositoryOperator);
          when(loginRepository.getOperatorById(any, any)).thenAnswer((_) async => repositoryOperator);
          final createdOperator = await loginUsecases.register(
              newOperator, newOperator.operatorOcupation);
              expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorRepository.deleteOperatorAccount(any, any, any, any)).thenReturn(null);
          await operatorUsecases.deleteOperatorAccount(createdOperator?.operatorCode,createdOperator?.operatorEmail
          , createdOperator?.operatorPassword, createdOperator?.operatorOcupation);
           when(loginRepository.getOperatorById(any, any)).thenAnswer((_) async => null);
             final currenteOperator = await loginRepository.getOperatorById("operatorId", "collection");
             expect(currenteOperator?.operatorId, equals(null));
        },
      );
      test(
        'Fail deleting operator account',
        () async {
when(loginRepository.register(any, any)).thenAnswer((_) async => repositoryOperator);
          when(loginRepository.getOperatorById(any, any)).thenAnswer((_) async => repositoryOperator);
          final createdOperator = await loginUsecases.register(
              newOperator, newOperator.operatorOcupation);
              expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorRepository.deleteOperatorAccount(any, any, any, any)).thenReturn(null);
          await operatorUsecases.deleteOperatorAccount(createdOperator?.operatorCode,null
          , createdOperator?.operatorPassword, createdOperator?.operatorOcupation);
           when(loginRepository.getOperatorById(any, any)).thenAnswer((_) async => null);
             final currenteOperator = await loginRepository.getOperatorById("operatorId", "collection");
             expect(currenteOperator?.operatorId, equals(null));
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
  operatorOcupation: "operator",
);
