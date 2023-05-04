import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_manager_by_id/iget_manager_by_id.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/manager_model.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';

class GetManagerByIdMock implements IGetManagerById {
  GetManagerByIdMock({required LoginRepository repository})
      : _repository = repository;

  final LoginRepository _repository;
  final _dataVerifier = DataVerifier();
  @override
  Future<ManagerEntity?> call(
      String? enterpriseId, String? operatorId, String? collection) async {
    if (_dataVerifier
        .validateInputData(inputs: [enterpriseId, operatorId, collection])) {
      final operatorModel =
          await _repository.getUserById(enterpriseId, operatorId, collection);
      return ManagerModel.toEntityData(operatorModel ?? ManagerModel());
    } else {
      return ManagerEntity();
    }
  }
}

void main() {
  final repository = LoginRepositoryMock();
  final getManagerById = GetManagerByIdMock(repository: repository);

  group(
    "GetOperatorById function should",
    () {
      test(
        "Call repository function to retrieve an operator entity",
        () async {
          when(repository.getUserById(any, any, any))
              .thenAnswer((_) async => LoginTestObjects.newManagerModel);
          final retriviedOperator =
              await getManagerById("enterpriseId", "operatorId", "collection");
          expect(retriviedOperator, isA<ManagerEntity>());
          expect(retriviedOperator != null, equals(true));
          expect(retriviedOperator?.managerId != null, equals(true));
        },
      );
      test(
        "Fail retrieving the entity",
        () async {
          when(repository.getUserById(any, any, any))
              .thenAnswer((_) async => null);
          final retriviedOperator = await getManagerById("", "operatorId", "collection");
          expect(retriviedOperator?.managerId == null, equals(true));
        },
      );
    },
  );
}