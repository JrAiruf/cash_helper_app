abstract class IResetOperatorPassword {
  Future<dynamic> call(String? email, String? operatorCode, String? newPassword);
}
