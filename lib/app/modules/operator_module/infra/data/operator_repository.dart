abstract class OperatorRepository {
  Future<dynamic> changeOperatorEmail(String? newEmail,String? operatorCode,String? operatorPassword,String? collection);
  Future<dynamic> deleteOperatorAccount(String? operatorCode,String? newEmail,String? operatorPassword,String? collection);
}