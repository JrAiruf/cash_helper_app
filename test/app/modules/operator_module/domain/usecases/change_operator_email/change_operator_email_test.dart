import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/usecases/change_operator_email/ichange_operator_email.dart';
import 'package:cash_helper_app/app/modules/operator_module/infra/data/operator_repository.dart';
import 'package:cash_helper_app/app/modules/operator_module/infra/models/operator_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../login_module/domain/usecases/login_usecases_impl_test.dart';
import '../operator_usecases_impl_test.dart';

class TestingUsecaseMock implements IChangeOperatorEmail {
  TestingUsecaseMock({required OperatorRepository repository})
      : _repository = repository;
  final OperatorRepository _repository;

  @override
  Future call(String? newEmail, String? operatorCode, String? operatorPassword,
      String? collection) async {
    if (_validOperatorData(newEmail, operatorCode, operatorPassword)) {
      await _repository.changeOperatorEmail(
          newEmail, operatorCode, operatorPassword, collection);
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
  final changeOperatorEmailUsecase =
      TestingUsecaseMock(repository: operatorRepository);
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
    "description",
    () {
      test(
        'change operator email ...',
        () async {
          when(loginRepository.register(any, any))
              .thenAnswer((_) async => repositoryOperator);
          when(loginRepository.getOperatorById(any, any))
              .thenAnswer((_) async => modifiedRepositoryOperator);
          final createdOperator = await loginUsecases.register(
              newOperator, newOperator.operatorOcupation);
          expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorRepository.changeOperatorEmail(any, any, any, any))
              .thenReturn(null);
          await changeOperatorEmailUsecase(
              "josy_kelly@email.com",
              createdOperator?.operatorCode,
              createdOperator?.operatorPassword,
              null);
          final currenteOperator =
              await loginUsecases.getOperatorById("operatorId", "collection");
          expect(
              currenteOperator?.operatorEmail, equals("josy_kelly@email.com"));
        },
      );
      test(
        'change operator email ...',
        () async {
          when(loginRepository.register(any, any))
              .thenAnswer((_) async => repositoryOperator);
          when(loginRepository.getOperatorById(any, any))
              .thenAnswer((_) async => repositoryOperator);
          final createdOperator = await loginUsecases.register(
              newOperator, newOperator.operatorOcupation);
          expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorRepository.changeOperatorEmail(any, any, any, any))
              .thenReturn(null);
          await changeOperatorEmailUsecase(null, createdOperator?.operatorCode,createdOperator?.operatorPassword, null);
          final currenteOperator =
              await loginUsecases.getOperatorById("operatorId", "collection");
          expect(currenteOperator?.operatorEmail, equals("josy@email.com"));
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
