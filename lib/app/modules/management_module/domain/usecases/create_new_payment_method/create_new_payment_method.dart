import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';

import '../../../../enterprise_module/infra/models/payment_method_model.dart';
import '../../../infra/data/management_repository.dart';
import 'icreate_new_payment_method.dart';

class CreateNewpaymentMethod implements ICreateNewpaymentMethod {
   CreateNewpaymentMethod({required ManagementRepository repository})
      : _repository = repository;
  final ManagementRepository _repository;
  @override
  Future<PaymentMethodEntity>? call(
      String enterpriseId, PaymentMethodEntity paymentMethod) async {
    final paymentMethodModel = PaymentMethodModel.fromEntityData(paymentMethod);
    final newPaymentMethod = await _repository.createNewPaymentMethod(
        enterpriseId, paymentMethodModel);
    return PaymentMethodModel.toEntityData(newPaymentMethod);
  }
}
