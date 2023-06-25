import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/usecases/open_operator_cash/iopen_operator_cash.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/data/operator_repository.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../../mocks/mocks.dart';
import '../../../../login_module/domain/usecases/get_user_by_id/get_user_by_id_test.dart';

class OpenOperatorCashMock implements IOpenOperatorCash {
  OpenOperatorCashMock({required OperatorRepository repository})
      : _repository = repository;

  final OperatorRepository _repository;
  @override
  Future<void> call(
          String enterpriseId, String operatorId, String oppeningTime) async =>
      await _repository.openOperatorCash(
          enterpriseId, operatorId, oppeningTime);
}

void main() {
  final loginRepository = LoginRepositoryMock();
  final login = GetUserByIdMock(
      dataVerifier: DataVerifier(), repository: loginRepository);
  final repository = OperatorRepositoryMock();
  final openOperatorCash = OpenOperatorCashMock(repository: repository);
  group(
    "OpenOperatorCash should",
    () {
      test(
        "Call Repository Layer to Open Operator's Cash",
        () async {
          when(loginRepository.getUserById(any, any, any))
              .thenAnswer((_) async => LoginTestObjects.enabledOperatorModel);
          when(repository.openOperatorCash(any, any, any)).thenReturn(null);
          final currentOperator =
              await login("enterpriseId", "operatorId", "collection")
                  as OperatorEntity;
          await openOperatorCash("enterpriseId","operatorId","Now'");
          expect(currentOperator.operatorEnabled, equals(true));
        },
      );
    },
  );
}
