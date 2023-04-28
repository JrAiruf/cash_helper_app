import 'package:cash_helper_app/app/modules/login_module/domain/usecases/register/iregister_operator.dart';
import 'package:cash_helper_app/app/modules/login_module/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/operator_module/infra/models/operator_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

class RegisterOperatorUsecaseMock implements IRegisterOperator {
  RegisterOperatorUsecaseMock({required LoginRepository repository})
      : _repository = repository;

  final LoginRepository _repository;
  final _dataVerifier = DataVerifier();

  @override
  Future<OperatorEntity?> call(OperatorEntity? newOperator, String? collection) async {
    if (_dataVerifier
        .validateInputData(inputs: [newOperator?.operatorId, collection])) {
     final operatorModelData = OperatorModel.fromEntityData(newOperator ?? OperatorEntity());
      final operatorModel = await _repository.register(operatorModelData, collection) ?? OperatorModel();
      return OperatorModel.toEntityData(operatorModel);
    } else {
      return null;
  }}
}

void main() {
  final repository = LoginRepositoryMock();
  final registerOperator = RegisterOperatorUsecaseMock(repository: repository);
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
    "Register function should",
    () {
      test(
        "Convert the object coming from repository, to register a new operator",
        () async {
          when(repository.register(any, any))
              .thenAnswer((_) async => repositoryOperator);
          when(repository.login(any, any, any))
              .thenAnswer((_) async => repositoryOperator);
          final createdOperator =
              await registerOperator(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
        },
      );
      test(
        "Fail to convert the object",
        () async {
          when(repository.register(any, any))
              .thenAnswer((_) async => null);
          final createdOperator = await registerOperator(null, "collection");
          expect(createdOperator?.operatorId == null, equals(true));
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
