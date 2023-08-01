abstract class LoginRepository {
  Future<dynamic>? register(dynamic newUser, String? enterpriseId, String? collection);
  Future<dynamic>? login(String? email, String? password, String? enterpriseId, String? collection);
  Future<dynamic>? getUserById(String? enterpriseId, String? userId, String? collection);
  Future<dynamic>? getAllOperators(String enterpriseId);
  Future<bool>? checkUserDataForResetPassword(String enterpriseId, String userEmail, String userCode, String collection);
  Future<void>? resetUserPassword(String? email, String userCode, String enterpriseId, String collection, String? newPassword);
  Future<void>? signOut();
}
