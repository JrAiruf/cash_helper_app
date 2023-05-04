import 'package:cash_helper_app/app/modules/login_module/domain/usecases/register_operator/iregister_operator.dart';
import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';

class RegisterOperatorUsecaseMock implements IRegisterOperator {
  RegisterOperatorUsecaseMock({required LoginRepository repository})
      : _repository = repository;

  final LoginRepository _repository;
  final _dataVerifier = DataVerifier();

  @override
  Future<OperatorEntity?> call(OperatorEntity? newOperator,String? enterpriseId,  String? collection) async {
     final operatorModelData = OperatorModel.fromEntityData(newOperator ?? OperatorEntity());
      final operatorModel = await _repository.register(operatorModelData, enterpriseId, collection) ?? OperatorModel();
      return OperatorModel.toEntityData(operatorModel);
   }
}

void main() {
  final repository = LoginRepositoryMock();
  final registerOperator = RegisterOperatorUsecaseMock(repository: repository);
  group(
    "Register function should",
    () {
      test(
        "Convert the object coming from repository, to register a new operator",
        () async {
          when(repository.register(any, any, any))
              .thenAnswer((_) async => LoginTestObjects.newOperatorModel);
          final createdOperator =
              await registerOperator(LoginTestObjects.newOperatorEntity, "enterpriseId", "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
        },
      );
      test(
        "Fail to convert the object",
        () async {
          when(repository.register(any, any,any))
              .thenAnswer((_) async => null);
          final createdOperator = await registerOperator(null,"", "collection");
          expect(createdOperator?.operatorId == null, equals(true));
        },
      );
    },
  );
}