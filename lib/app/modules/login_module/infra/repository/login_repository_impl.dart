import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/operator_module/infra/models/operator_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<bool>? checkOperatorDataForResetPassword(String? email, int? cashierNumber, String? collection) {
    // TODO: implement checkOperatorDataForResetPassword
    throw UnimplementedError();
  }

  @override
  Future<OperatorModel?>? getOperatorById(String? operatorId, String? collection) {
    // TODO: implement getOperatorById
    throw UnimplementedError();
  }

  @override
  Future<OperatorModel?>? login(String? email, String? password, String? collection) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<OperatorModel?>? register(OperatorModel? newOperator, String? collection) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<void>? resetOperatorPassword(String? email, int? cashierNumber, String? collection, String? newPassword) {
    // TODO: implement resetOperatorPassword
    throw UnimplementedError();
  }

  @override
  Future<void>? signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}