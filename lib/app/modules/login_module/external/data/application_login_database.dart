abstract class ApplicationLoginDatabase {
Future<Map<String,dynamic>?>? register(Map<String,dynamic>? newOperator, String? collection);
Future<Map<String,dynamic>?>? login(String? email, String? password, String? collection);
Future<Map<String,dynamic>?>? getOperatorById(String? operatorId, String? collection);
Future<bool>? checkOperatorDataForResetPassword(String? email, int? cashierNumber, String? collection);
Future<void>? resetOperatorPassword( String? email, int? cashierNumber, String? collection, String? newPassword);
Future<void>? signOut();
}