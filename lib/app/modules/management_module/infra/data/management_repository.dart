import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/payment_method_model.dart';

abstract class ManagementRepository {
  Future<dynamic>? getOperatorsInformations(String enterpriseId);
  Future<dynamic>? createNewPaymentMethod(String enterpriseId, PaymentMethodModel paymentMethod);
}
