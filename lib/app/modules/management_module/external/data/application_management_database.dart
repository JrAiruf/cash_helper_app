abstract class ApplicationManagementDatabase {
  Future<dynamic>? getOperatorInformations(String enterpriseId);
  Future<dynamic>? createNewPaymentMethod(String enterpriseId,Map<String, dynamic> paymentMethod);
}
