abstract class PaymentMethodsListEvents {}

class GetAllPaymentMethodsEvent implements PaymentMethodsListEvents {
  final String enterpriseId;

  GetAllPaymentMethodsEvent(this.enterpriseId);
}
