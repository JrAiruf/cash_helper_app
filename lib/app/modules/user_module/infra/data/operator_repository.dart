abstract class OperatorRepository {
  Future<dynamic>? changeOperatorEmail(String? newEmail,String? operatorCode,String? operatorPassword,String? collection);
  Future<dynamic>? changeOperatorPassword(String? newPassword,String? operatorCode, String? currentPassword, String? collection);
   Future<dynamic>? openOperatorCash(String? enterpriseId, String? operatorId, String? oppeningTime);
  Future<dynamic>? closeOperatorCash(String? enterpriseId, String? operatorId, String? closingTime);
  Future<dynamic>? deleteOperatorAccount(String? operatorCode,String? operatorEmail,String? operatorPassword,String? collection);
  
}