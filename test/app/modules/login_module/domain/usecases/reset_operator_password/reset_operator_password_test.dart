import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/reset_operator_password/ireset_operator_password.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../../mocks/mocks.dart';
import '../get_user_by_id/get_user_by_id_test.dart';
import '../register_operator/register_operator_test.dart';

class ResetOperatorPasswordUsecaseMock implements IResetOperatorPassword {
  ResetOperatorPasswordUsecaseMock({required LoginRepository repository})
      : _repository = repository;

  final LoginRepository _repository;
  final _dataVerifier = DataVerifier();
  @override
  Future call(String? email, String? operatorCode, String? newPassword) async {
    return _dataVerifier.validateInputData(inputs: [email, operatorCode, newPassword])
        ? _repository.resetOperatorPassword(email, operatorCode, newPassword)
        : null;
  }
}

void main() {
  final repository = LoginRepositoryMock();
  final register = RegisterOperatorUsecaseMock(repository: repository);
  final getOperatorById = GetUserByIdMock(repository: repository,dataVerifier: DataVerifier());
  final resetOperatorPassword =
      ResetOperatorPasswordUsecaseMock(repository: repository);
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
    "ResetOperatorPassword function should",
    () {
      test(
        "Call repository function to reset operator's password",
        () async {
          when(repository.register(any, any))
              .thenAnswer((_) async => repositoryOperator);
          when(repository.getOperatorById(any, any))
              .thenAnswer((_) async => modifiedRepositoryOperator);
          when(repository.resetOperatorPassword(any, any, any))
              .thenReturn(null);

          final createdOperator = await register(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
          await resetOperatorPassword(createdOperator?.operatorEmail,
              createdOperator?.operatorCode, "newPassword");
          final currentOperator = await getOperatorById(
              createdOperator?.operatorEmail, "collection");

          expect(currentOperator?.operatorPassword, equals("newPassword"));
        },
      );
      test(
        "Fail reseting operator's password",
        () async {
          when(repository.register(any, any))
              .thenAnswer((_) async => repositoryOperator);
          when(repository.getOperatorById(any, any))
              .thenAnswer((_) async => repositoryOperator);
          when(repository.resetOperatorPassword(any, any, any))
              .thenReturn(null);

          final createdOperator = await register(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
          await resetOperatorPassword(createdOperator?.operatorEmail,
              createdOperator?.operatorCode, "newPassword");
          final currentOperator = await getOperatorById(
              createdOperator?.operatorEmail, "collection");

          expect(currentOperator?.operatorPassword, equals("12345678"));
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
  operatorEmail: 'josy@email.com',
  operatorPassword: 'newPassword',
  operatorCode: 'newPas',
  operatorOppening: 'operatorOppening',
  operatorClosing: 'operatorClosing',
  operatorEnabled: false,
  businessPosition: "operator",
);
