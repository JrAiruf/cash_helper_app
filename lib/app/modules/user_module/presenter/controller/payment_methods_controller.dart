import 'package:flutter/cupertino.dart';

import '../../../enterprise_module/domain/entities/payment_method_entity.dart';
import '../../../management_module/domain/usecases/get_all_payment_methods/iget_all_payment_methods.dart';

class PaymentMethodsController
    extends ValueNotifier<List<PaymentMethodEntity>> {
  PaymentMethodsController(
      {required IGetAllPaymentMethods getAllPaymentMethods})
      : _getAllPaymentMethods = getAllPaymentMethods,
        super([]);

  final IGetAllPaymentMethods _getAllPaymentMethods;
  List<PaymentMethodEntity> get paymentMethods => value;

  void getPaymentMethodsInformations(String enterpriseId) async {
    final enterprisePayamentMethodsList =
        await _getAllPaymentMethods(enterpriseId) as List<PaymentMethodEntity>;
    value = enterprisePayamentMethodsList;
  }
}
