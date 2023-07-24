import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';

abstract class PaymentMethodEvents {}

class CreateNewPaymentMethod implements PaymentMethodEvents {
  final String enterpriseId;
  final PaymentMethodEntity paymentMethod;

  CreateNewPaymentMethod(this.enterpriseId, this.paymentMethod);
}
