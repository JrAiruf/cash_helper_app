// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentMethodEntity {
  String? paymentMethodId;
  String? paymentMethodName;
  String? paymentMethodDescription;
  double? paymentMethodUsingRate;

  PaymentMethodEntity({
   required this.paymentMethodId,
   required this.paymentMethodName,
   required this.paymentMethodDescription,
   required this.paymentMethodUsingRate,
  });
}
