// ignore_for_file: unused_import, unused_local_variable

import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/sign_out/isign_out.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../../mocks/mocks.dart';
import '../get_user_by_id/get_user_by_id_test.dart';
import '../register_operator/register_operator_test.dart';

class SignOutMock implements ISignOut {
  SignOutMock({required LoginRepository repository}) : _repository = repository;

  final LoginRepository _repository;

  @override
  Future<void> call() async {
    await _repository.signOut();
  }
}

void main() {
  final repository = LoginRepositoryMock();
  final getOperatorById =
      GetUserByIdMock(repository: repository, dataVerifier: DataVerifier());
  final signOut = SignOutMock(repository: repository);

  test(
    "Should sign out the application",
    () async {
      when(repository.getUserById(any, any, any)).thenAnswer((_) async => null);
      when(repository.signOut()).thenReturn(null);

      await signOut();
      final loggedOffOperator =
          await getOperatorById("id", "collection", "collection");
      expect(loggedOffOperator?.operatorId, equals(null));
    },
  );
}
