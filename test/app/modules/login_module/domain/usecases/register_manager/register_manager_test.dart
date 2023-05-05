import 'package:cash_helper_app/app/modules/login_module/domain/usecases/register_manager/iregister_manager.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/manager_model.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';


class RegisterManagerUsecaseMock implements IRegisterManager {
  RegisterManagerUsecaseMock({required LoginRepository repository})
      : _repository = repository;

  final LoginRepository _repository;
  @override
  Future<ManagerEntity?> call(ManagerEntity? newOperator,String? enterpriseId,  String? collection) async {
     final operatorModelData = ManagerModel.fromEntityData(newOperator ?? ManagerEntity());
      final operatorModel = await _repository.register(operatorModelData, enterpriseId, collection) ?? ManagerModel();
      return ManagerModel.toEntityData(operatorModel);
   }
}

void main() {
  final repository = LoginRepositoryMock();
  final registerManager = RegisterManagerUsecaseMock(repository: repository);
  group(
    "Register function should",
    () {
      test(
        "Convert the object coming from repository, to register a new operator",
        () async {
          when(repository.register(any, any, any))
              .thenAnswer((_) async => LoginTestObjects.newManagerModel);
          final createdOperator =
              await registerManager(LoginTestObjects.newManagerEntity, "enterpriseId", "collection");
          expect(createdOperator, isA<ManagerEntity>());
          expect(createdOperator?.managerId != null, equals(true));
        },
      );
      test(
        "Fail to convert the object",
        () async {
          when(repository.register(any, any,any))
              .thenAnswer((_) async => null);
          final createdOperator = await registerManager(null,"", "collection");
          expect(createdOperator?.managerId == null, equals(true));
        },
      );
    },
  );
}