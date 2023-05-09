import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';

abstract class ICreatePaymentMethod {
  Future<dynamic>? call(PaymentMethodEntity paymentMethodEntity, String managerCode);
}
