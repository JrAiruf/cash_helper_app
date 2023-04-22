abstract class OperatorUsecases {
  Future<dynamic> changeOperatorEmail(String? newEmail,String? operatorCode,String? operatorPassword,String? collection);
  Future<dynamic>? changeOperatorPassword(String? newPassword,String? operatorCode, String? currentPassword, String? collection);
  Future<dynamic> deleteOperatorAccount(String? operatorCode,String? newEmail,String? operatorPassword,String? collection);
}
