import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/payment_method_model.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';

abstract class ManagementRepository {
  Future<dynamic>? getOperatorsInformations(String enterpriseId);
  Future<dynamic>? createNewPaymentMethod(String enterpriseId, PaymentMethodModel paymentMethod);
  Future<dynamic>? getAllPaymentMethods(String enterpriseId);
  Future<dynamic>? removePaymentMethod(String enterpriseId, String paymentMethodId);
  Future<dynamic>? generatePendency(String enterpriseId, PendencyEntity pendency);
  Future<dynamic>? getPendencyById(String enterpriseId, String pendencyId);
  Future<dynamic>? getAllPendencies(String enterpriseId);
  Future<dynamic>? finishPendency(String enterpriseId, String pendencyId);
}
