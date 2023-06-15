abstract class OperatorDatabase {
  Future<dynamic>? changeUserEmail(String? newEmail,String? operatorCode,String? operatorPassword, String? collection);
  Future<dynamic>? changeUserPassword(String? newPassword,String? operatorCode, String? currentPassword, String? collection);
  Future<dynamic>? openOperatorCash(String? enterpriseId, String? operatorId, String? oppeningTime);
  Future<dynamic>? closeOperatorCash(String? operatorId, String? collection);
  Future<dynamic>? deleteUserAccount(String? operatorCode,String? newEmail,String? operatorPassword,String? collection);
}