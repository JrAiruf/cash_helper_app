import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_operator_by_id/iget_operator_by_id.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import '../register_operator/register_operator_test.dart';

class GetOperatorByIdMock implements IGetOperatorById {
GetOperatorByIdMock({required LoginRepository repository})
      : _repository = repository;

  final LoginRepository _repository;
  final _dataVerifier = DataVerifier();
  @override
  Future<OperatorEntity?> call(String? operatorId, String? collection) async {
   if(_dataVerifier.validateInputData(inputs: [operatorId,collection])){
        final operatorModel = await _repository.getOperatorById(operatorId, collection);
        return OperatorModel.toEntityData(operatorModel ?? OperatorModel());
   } else {
    return OperatorEntity();
   }
  }
}

void main() {
  final repository = LoginRepositoryMock();
  final register = RegisterOperatorUsecaseMock(repository: repository);
  final getOperatorById = GetOperatorByIdMock(repository: repository);
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
  );
  group(
    "GetOperatorById function should",
    () {
      test(
        "Call repository function to retrieve operator entity",
        () async {
          when(repository.register(any, any))
              .thenAnswer((_) async => repositoryOperator);
          when(repository.getOperatorById(any, any))
              .thenAnswer((_) async => repositoryOperator);
          final createdOperator =
              await register(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
          final retriviedOperator = await getOperatorById(
              createdOperator?.operatorEmail, "collection");
          expect(retriviedOperator, isA<OperatorEntity>());
          expect(retriviedOperator != null, equals(true));
          expect(retriviedOperator?.operatorId != null, equals(true));
        },
      );
      test(
        "Fail retrieving the entity",
        () async {
          when(repository.register(any, any))
              .thenAnswer((_) async => repositoryOperator);
          when(repository.getOperatorById(any, any))
              .thenAnswer((_) async => null);
          final createdOperator =
              await register(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
          final retriviedOperator =
              await getOperatorById(null, "collection");
          expect(retriviedOperator?.operatorId, equals(null));
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
