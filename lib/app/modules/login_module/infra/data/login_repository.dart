import 'package:cash_helper_app/app/modules/operator_module/infra/models/operator_model.dart';

abstract class LoginRepository {
Future<OperatorModel?>? register(OperatorModel? newOperator, String? collection);
Future<OperatorModel?>? login(String? email, String? password, String? collection);
Future<OperatorModel?>? getOperatorById(String? operatorId, String? collection);
Future<bool>? checkOperatorDataForResetPassword(String? email, int? cashierNumber, String? collection);
Future<void>? resetOperatorPassword( String? email, int? cashierNumber, String? collection, String? newPassword);
Future<void>? signOut();
}