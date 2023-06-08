import 'package:flutter/cupertino.dart';

import '../../../enterprise_module/domain/entities/payment_method_entity.dart';
import '../../../management_module/domain/usecases/payment_methods/get_all_payment_methods/iget_all_payment_methods.dart';

class PaymentMethodsController
    extends ValueNotifier<List<PaymentMethodEntity>> {
  PaymentMethodsController(
      {required IGetAllPaymentMethods getAllPaymentMethods})
      : _getAllPaymentMethods = getAllPaymentMethods,
        super([]);

  final IGetAllPaymentMethods _getAllPaymentMethods;
  List<PaymentMethodEntity> paymentMethodsList = [];

  Future<List<PaymentMethodEntity>> getPaymentMethodsInformations(
      String enterpriseId) async {
    paymentMethodsList = await _getAllPaymentMethods(enterpriseId);
    value = paymentMethodsList;
    return value;
  }
}
