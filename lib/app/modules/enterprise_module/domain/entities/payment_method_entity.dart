// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentMethodEntity {
  String? paymentMethodId;
  String? paymentMethodName;
  String? paymentMethodDescription;
  double? paymentMethodUsingRate;

  PaymentMethodEntity({
    this.paymentMethodId,
    this.paymentMethodName,
    this.paymentMethodDescription,
    this.paymentMethodUsingRate,
  });
}
