import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/usecases/close_operator_cash/iclose_operator_cash.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/data/operator_repository.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import '../../../../login_module/domain/usecases/get_user_by_id/get_user_by_id_test.dart';

class CloseOperatorCashMock implements ICloseOperatorCash {
CloseOperatorCashMock({required OperatorRepository repository})
      : _repository = repository;

  final OperatorRepository _repository;
  @override
  Future<void> call(String enterpriseId, String operatorId, String closingTime) async =>
      await _repository.openOperatorCash(
          enterpriseId, operatorId, closingTime);
}
void main() {
   final loginRepository = LoginRepositoryMock();
  final login = GetUserByIdMock(
      dataVerifier: DataVerifier(), repository: loginRepository);
  final repository = OperatorRepositoryMock();
  final closeOperatorCash = CloseOperatorCashMock(repository: repository);
 group(
    "CloseOperatorCash should",
    () {
      test(
        "Call Repository Layer to Close Operator's Cash",
        () async {
          when(loginRepository.getUserById(any, any, any))
              .thenAnswer((_) async => LoginTestObjects.newOperatorModel);
          when(repository.closeOperatorCash(any, any, any)).thenReturn(null);
          final currentOperator =
              await login("enterpriseId", "operatorId", "collection")
                  as OperatorEntity;
          await closeOperatorCash("enterpriseId","operatorId","Now'");
          expect(currentOperator.operatorEnabled, equals(false));
        },
      );
    },
  );
}