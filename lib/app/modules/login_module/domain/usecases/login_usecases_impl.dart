import 'package:cash_helper_app/app/modules/login_module/domain/contract/login_usecases.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';

class LoginUsecasesImpl implements LoginUsecases {
  @override
  Future<bool>? checkOperatorDataForResetPassword(String? email, int? cashierNumber, String? collection) {
    // TODO: implement checkOperatorDataForResetPassword
    throw UnimplementedError();
  }

  @override
  Future<OperatorEntity?>? getOperatorById(String? operatorId, String? collection) {
    // TODO: implement getOperatorById
    throw UnimplementedError();
  }

  @override
  Future<OperatorEntity?>? login(String? email, String? password, String? collection) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<OperatorEntity?>? register(OperatorEntity? newOperator, String? collection) {
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
