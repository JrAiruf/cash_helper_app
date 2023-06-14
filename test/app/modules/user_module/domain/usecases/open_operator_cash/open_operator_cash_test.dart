import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/repository/login_repository_impl.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/usecases/open_operator_cash/iopen_operator_cash.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/data/operator_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/repository/operator_repository_impl.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../login_module/domain/usecases/get_user_by_id/get_user_by_id_test.dart';

class OperatorRepositoryMock extends Mock implements OperatorRepositoryImpl {}

class LoginRepositoryMock extends Mock implements LoginRepositoryImpl {}

class OpenOperatorCashMock implements IOpenOperatorCash {
  OpenOperatorCashMock({required OperatorRepository repository})
      : _repository = repository;

  final OperatorRepository _repository;
  @override
  Future<void> call(
      String enterpriseId, String operatorId, String oppeningTime) async {
    // TODO: implement call
    throw UnimplementedError();
  }
}

void main() {
  late OperatorRepositoryMock repository;
  late LoginRepositoryMock loginRepository;
  late GetUserByIdMock getUserById;
  late OpenOperatorCashMock usecase;

  setUp(
    () {
      repository = OperatorRepositoryMock();
      loginRepository = LoginRepositoryMock();
      getUserById = GetUserByIdMock(
          repository: loginRepository, dataVerifier: DataVerifier());
      usecase = OpenOperatorCashMock(repository: repository);
    },
  );
  group("OpenOperatorCash Usecase Should", () {
    test(
      "Change Operator's State to Active, and Save the OppeningTime",
      () async {
        when(repository.openOperatorCash(any, any, any)).thenReturn(null);
        when(loginRepository.getUserById(any, any, any)).thenAnswer((_)async => LoginTestObjects.activeOperator);
        await usecase("enterpriseId", "operatorId", "Now");
      },
    );
  });
}
