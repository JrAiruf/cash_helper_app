import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';

abstract class ApplicationLoginDatabase {
  Future<void>? register(Map<String,dynamic>? newOperator, String? collection);
 Future<void>? login(String? email, String? password, String? collection);
  Future<Map<String,dynamic>?>? getOperatorById(String? operatorId);
   Future<bool>? checkOperatorDataForResetPassword(String? email, int? cashierNumber);
  Future<void>? resetOperatorPassword( String? email, int? cashierNumber, String? newPassword);
  Future<void>? signOut();
}