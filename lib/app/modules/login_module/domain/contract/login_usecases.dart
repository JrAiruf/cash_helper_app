import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';

abstract class LoginUsecases {
  Future<OperatorEntity?>? register(OperatorEntity? newOperator, String? collection);
Future<OperatorEntity?>? login(String? email, String? password, String? collection);
Future<OperatorEntity?>? getOperatorById(String? operatorId, String? collection);
Future<bool>? checkOperatorDataForResetPassword(String? email, String? operatorCode, String? collection);
Future<void>? resetOperatorPassword( String? email, String? operatorCode, String? newPassword);
Future<void>? signOut();
}