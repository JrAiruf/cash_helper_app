abstract class ICheckOperatorDataForResetPassword {
  Future<dynamic> call(String? email, String? operatorCode, String? collection);
}