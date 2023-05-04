import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_operator_by_id/iget_operator_by_id.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../../mocks/mocks.dart';

class GetOperatorByIdMock implements IGetOperatorById {
  GetOperatorByIdMock({required LoginRepository repository})
      : _repository = repository;

  final LoginRepository _repository;
  final _dataVerifier = DataVerifier();
  @override
  Future<OperatorEntity?> call(
      String? enterpriseId, String? operatorId, String? collection) async {
    if (_dataVerifier
        .validateInputData(inputs: [enterpriseId, operatorId, collection])) {
      final operatorModel =
          await _repository.getUserById(enterpriseId, operatorId, collection);
      return OperatorModel.toEntityData(operatorModel ?? OperatorModel());
    } else {
      return OperatorEntity();
    }
  }
}

void main() {
  final repository = LoginRepositoryMock();
  final getOperatorById = GetOperatorByIdMock(repository: repository);

  group(
    "GetOperatorById function should",
    () {
      test(
        "Call repository function to retrieve an operator entity",
        () async {
          when(repository.getUserById(any, any, any))
              .thenAnswer((_) async => LoginTestObjects.newOperatorModel);
          final retriviedOperator =
              await getOperatorById("enterpriseId", "operatorId", "collection");
          expect(retriviedOperator, isA<OperatorEntity>());
          expect(retriviedOperator != null, equals(true));
          expect(retriviedOperator?.operatorId != null, equals(true));
        },
      );
      test(
        "Fail retrieving the entity",
        () async {
          when(repository.getUserById(any, any, any))
              .thenAnswer((_) async => null);
          final retriviedOperator = await getOperatorById("", "operatorId", "collection");
          expect(retriviedOperator?.operatorId == null, equals(true));
        },
      );
    },
  );
}