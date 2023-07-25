import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';

abstract class PaymentMethodEvents {}

class CreateNewPaymentMethodEvent implements PaymentMethodEvents {
  final String enterpriseId;
  final PaymentMethodEntity paymentMethod;

  CreateNewPaymentMethodEvent(this.enterpriseId, this.paymentMethod);
}