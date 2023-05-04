import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/login/ilogin.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/manager_model.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';

class LoginUsecaseMock implements ILogin {
  LoginUsecaseMock({
    required LoginRepository repository,
    required DataVerifier dataVerifier,
  }) : _repository = repository,
   _dataVerifier = dataVerifier;

  final LoginRepository _repository;
  final DataVerifier _dataVerifier;

  @override
  Future<dynamic> call(String? email, String? password, String? enterpriseId,
      String? collection) async {
    if (_dataVerifier.validateInputData(
        inputs: [email, password, enterpriseId, collection])) {
      final repositoryModel =
          await _repository.login(email, password, enterpriseId, collection);
      if (_dataVerifier.operatorModelVerifier(model: repositoryModel)) {
        return OperatorModel.toEntityData(repositoryModel ?? OperatorModel());
      } else if (_dataVerifier.managerModelVerifier(model: repositoryModel)) {
        return ManagerModel.toEntityData(repositoryModel ?? ManagerModel());
      }
    } else {
      return null;
    }
  }
}

void main() {
  final repository = LoginRepositoryMock();
  final login = LoginUsecaseMock(repository: repository,dataVerifier: DataVerifier());
  group(
    "Login function should",
    () {
      test(
        "Call repository function to authenticate an operator and signIn",
        () async {
          when(repository.login(any, any, any, any))
              .thenAnswer((_) async => LoginTestObjects.newOperatorModel);
          final loginOperator =
              await login("email", "password", "enterpriseId", "collection");
          expect(loginOperator, isA<OperatorEntity>());
          expect(loginOperator?.operatorId != null, equals(true));
        },
      );
      test(
        "Call repository function to authenticate a manager and signIn",
        () async {
          when(repository.login(any, any, any, any))
              .thenAnswer((_) async => LoginTestObjects.newManagerModel);
          final loginOperator =
              await login("email", "password", "enterpriseId", "collection");
          expect(loginOperator, isA<ManagerEntity>());
          expect(loginOperator?.managerId != null, equals(true));
        },
      );
      test(
        "Fail to sign In",
        () async {
          when(repository.login(any, any, any, any))
              .thenAnswer((_) async => null);
          final loginOperator = await login("", "password", null, "collection");
          expect(loginOperator == null, equals(true));
        },
      );
    },
  );
}
