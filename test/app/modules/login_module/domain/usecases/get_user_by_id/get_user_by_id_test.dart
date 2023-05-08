import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_user_by_id/iget_user_by_id.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/manager_model.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';

class GetUserByIdMock implements IGetUserById {
  GetUserByIdMock({
    required LoginRepository repository,
    required DataVerifier dataVerifier,
  })  : _repository = repository,
        _dataVerifier = dataVerifier;

  final LoginRepository _repository;
  final DataVerifier _dataVerifier;
  @override
  Future<dynamic> call(
      String? enterpriseId, String? userId, String? collection) async {
    final userModel =
        await _repository.getUserById(enterpriseId, userId, collection);
    if (_dataVerifier.operatorModelVerifier(model: userModel)) {
      return OperatorModel.toEntityData(userModel);
    } else if (_dataVerifier.managerModelVerifier(model: userModel)) {
      return ManagerModel.toEntityData(userModel);
    } else {
      return null;
    }
  }
}

void main() {
  final repository = LoginRepositoryMock();
  final getUserById = GetUserByIdMock(repository: repository,dataVerifier: DataVerifier());

  group(
    "GetUserById function should",
    () {
      test(
        "Call repository function to retrieve an operator entity",
        () async {
          when(repository.getUserById(any, any, any))
              .thenAnswer((_) async => LoginTestObjects.newOperatorModel);
          final retriviedOperator =
              await getUserById("enterpriseId", "operatorId", "collection");
          expect(retriviedOperator, isA<OperatorEntity>());
          expect(retriviedOperator != null, equals(true));
          expect(retriviedOperator?.operatorId != null, equals(true));
        },
      );
      test(
        "Call repository function to retrieve an manager entity",
        () async {
          when(repository.getUserById(any, any, any))
              .thenAnswer((_) async => LoginTestObjects.newManagerModel);
          final retriviedOperator =
              await getUserById("enterpriseId", "operatorId", "collection");
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
          final retriviedOperator =
              await getUserById("", "operatorId", "collection");
          expect(retriviedOperator?.operatorId == null, equals(true));
        },
      );
    },
  );
}
