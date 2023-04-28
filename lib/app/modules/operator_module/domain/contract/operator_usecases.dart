import 'package:cash_helper_app/app/modules/operator_module/domain/usecases/change_operator_email/ichange_operator_email.dart';

abstract class OperatorUsecases {
  Future<dynamic> changeOperatorEmail(String? newEmail, String? operatorCode,
      String? operatorPassword, String? collection);
  Future<dynamic>? changeOperatorPassword(String? newPassword,
      String? operatorCode, String? currentPassword, String? collection);
  Future<dynamic> deleteOperatorAccount(String? operatorCode,
      String? operatorEmail, String? operatorPassword, String? collection);
}