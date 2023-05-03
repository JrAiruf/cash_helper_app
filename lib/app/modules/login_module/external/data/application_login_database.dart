abstract class ApplicationLoginDatabase {
Future<Map<String,dynamic>?>? register(Map<String,dynamic>? newUser,String? enterpriseId, String? collection);
Future<Map<String,dynamic>?>? login(String? email, String? password, String? enterpriseId, String? collection);
Future<Map<String,dynamic>?>? getOperatorById(String? enterpriseId, String? operatorId,String? collection);
Future<bool>? checkOperatorDataForResetPassword(String? email, String? operatorCode, String? enterpriseId, String? collection);
Future<void>? resetOperatorPassword(String? email, String? operatorCode,String? enterpriseId, String? newPassword);
Future<void>? signOut();
}