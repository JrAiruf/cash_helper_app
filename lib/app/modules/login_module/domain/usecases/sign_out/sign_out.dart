import 'package:cash_helper_app/app/modules/login_module/domain/usecases/sign_out/isign_out.dart';

import '../../../infra/data/login_repository.dart';

class SignOut implements ISignOut {
SignOut({required LoginRepository repository}) : _repository = repository;

  final LoginRepository _repository;

  @override
  Future<void> call() async {
    await _repository.signOut();
  }
}