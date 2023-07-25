abstract class ApplicationLoginDatabase {
Future<dynamic>? register(Map<String,dynamic> newUser,String enterpriseId, String collection);
Future<dynamic>? login(String email, String password, String enterpriseId, String collection);
Future<dynamic>? getUserById(String enterpriseId, String operatorId,String collection);
Future<dynamic>? getAllOperators(String enterpriseId);
Future<bool>? checkOperatorDataForResetPassword(String? email, String? operatorCode, String? enterpriseId, String? collection);
Future<void>? resetUserPassword(String email, String operatorCode,String enterpriseId, String newPassword);
Future<void>? signOut();
}