import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/domain/usecases/create_payment_method/icreate_payment_method.dart';

class CreatePaymentMethod implements ICreatePaymentMethod {
  @override
  Future? call(PaymentMethodEntity paymentMethodEntity, String managerCode) {
    // TODO: implement call
    throw UnimplementedError();
  }
}