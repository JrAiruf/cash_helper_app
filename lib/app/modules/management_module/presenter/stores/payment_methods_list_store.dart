import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/usecases/get_all_payment_methods/iget_all_payment_methods.dart';

class PaymentMethodsListStore
    extends ValueNotifier<List<PaymentMethodEntity>?> {
  PaymentMethodsListStore({required IGetAllPaymentMethods getAllPaymentMethods})
      : _getAllPaymentMethods = getAllPaymentMethods,
        super([]);
  final IGetAllPaymentMethods _getAllPaymentMethods;
  final loadingState = ValueNotifier(false);

  Future<void> getAllPaymentMethods(String enterpriseId) async {
    final paymentMethods =
        await _getAllPaymentMethods(enterpriseId) as List<PaymentMethodEntity>;
    if (paymentMethods.isNotEmpty) {
      value = paymentMethods;
    } else if (paymentMethods.isEmpty) {
      value = [];
    } else {
      value = null;
    }
  }
}
