import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/payment_method_model.dart';

abstract class ManagementRepository {
  Future<dynamic>? getOperatorsInformations(String enterpriseId);
  Future<dynamic>? createNewPaymentMethod(String enterpriseId, PaymentMethodModel paymentMethod);
  Future<dynamic>? getAllPaymentMethods(String enterpriseId);
  Future<dynamic>? removePaymentMethod(String enterpriseId, String paymentMethodId);
  Future<dynamic>? generatePendency(String enterpriseId, String operatorId, String annotationId);
  Future<dynamic>? getPendencyById(String enterpriseId, String pendencyId);
  Future<dynamic>? getAllPendencies(String enterpriseId);
  Future<dynamic>? finishPendency(String enterpriseId, String pendencyId);
}
