abstract class ApplicationManagementDatabase {
  Future<dynamic>? getOperatorInformations(String enterpriseId);
  Future<dynamic>? createNewPaymentMethod(String enterpriseId,Map<String, dynamic> paymentMethod);
  Future<dynamic>? getAllPaymentMethods(String enterpriseId);
  Future<dynamic>? removePaymentMethod(String enterpriseId,String paymentMethodId);
}
