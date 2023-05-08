abstract class LoginRepository {
Future<dynamic>? register(dynamic newUser, String? enterpriseId, String? collection);
Future<dynamic>? login(String? email, String? password, String? enterpriseId, String? collection);
Future<dynamic>? getUserById(String? enterpriseId, String? operatorId, String? collection);
Future<bool>? checkOperatorDataForResetPassword(String? email, String? operatorCode, String? collection);
Future<void>? resetOperatorPassword( String? email, String? operatorCode, String? newPassword);
Future<void>? signOut();
}