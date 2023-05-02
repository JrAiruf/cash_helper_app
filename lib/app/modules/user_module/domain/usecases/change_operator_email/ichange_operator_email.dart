abstract class IChangeOperatorEmail{
  Future<void> call(String? newEmail, String? operatorCode,String? operatorPassword, String? collection);
}