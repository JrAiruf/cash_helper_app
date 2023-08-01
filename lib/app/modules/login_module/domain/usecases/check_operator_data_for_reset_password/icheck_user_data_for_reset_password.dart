abstract class ICheckUserDataForResetPassword {
  Future<dynamic> call(String enterpriseId, String userEmail, String userrCode, String collection);
}