abstract class IChangeOperatorPassword {
  Future<dynamic> call(String? newPassword, String? operatorCode,String? currentPassword, String? collection);
}
