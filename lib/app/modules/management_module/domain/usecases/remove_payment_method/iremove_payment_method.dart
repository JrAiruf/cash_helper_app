abstract class IRemovePaymentMethod {
  Future<dynamic>? call(String enterpriseId, String paymentMethodId);
}
