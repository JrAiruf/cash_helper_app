abstract class ApplicationManagementDatabase {
  Future<dynamic>? getOperatorInformations(String enterpriseId);
  Future<dynamic>? createNewPaymentMethod(String enterpriseId, Map<String, dynamic> paymentMethod);
  Future<dynamic>? getAllPaymentMethods(String enterpriseId);
  Future<dynamic>? removePaymentMethod(String enterpriseId, String paymentMethodId);
  Future<dynamic>? generatePendency(String enterpriseId, Map<String,dynamic> pendency);
  Future<dynamic>? getPendencyById(String enterpriseId, String pendencyId);
  Future<dynamic>? getAllPendencies(String enterpriseId);
  Future<dynamic>? finishPendency(String enterpriseId, String pendencyId);
}
