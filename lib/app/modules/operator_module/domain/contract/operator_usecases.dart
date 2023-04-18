abstract class OperatorUsecases {
  Future<dynamic> changeOperatorEmail(String? newEmail,String? operatorCode,String? operatorPassword);
  Future<dynamic> deleteOperatorAccount(String? operatorCode,String? newEmail,String? operatorPassword);
}
