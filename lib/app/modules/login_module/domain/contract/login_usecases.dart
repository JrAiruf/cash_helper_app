import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';

abstract class LoginUsecases {
  Future<OperatorEntity?>? register(OperatorEntity? newOperator, String? collection);
Future<OperatorEntity?>? login(String? email, String? password, String? collection);
Future<OperatorEntity?>? getOperatorById(String? operatorId, String? collection);
Future<bool>? checkOperatorDataForResetPassword(String? email, int? cashierNumber, String? collection);
Future<void>? resetOperatorPassword( String? email, int? cashierNumber, String? collection, String? newPassword);
Future<void>? signOut();
}