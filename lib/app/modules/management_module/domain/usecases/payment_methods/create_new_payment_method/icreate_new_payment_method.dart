import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';

abstract class ICreateNewpaymentMethod {
  Future<dynamic>? call(String enterpriseId, PaymentMethodEntity paymentMethod);
}
