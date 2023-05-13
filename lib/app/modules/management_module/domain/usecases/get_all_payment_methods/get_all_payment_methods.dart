import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';

import '../../../../enterprise_module/domain/entities/payment_method_entity.dart';
import '../../../../enterprise_module/infra/models/payment_method_model.dart';
import 'iget_all_payment_methods.dart';

class GetAllPaymentMethods implements IGetAllPaymentMethods {
  GetAllPaymentMethods({required ManagementRepository repository})
      : _repository = repository;

  final ManagementRepository _repository;

  @override
  Future<List<PaymentMethodEntity>>? call(String enterpriseId) async {
    final repositoryPaymentMethods =
        await _repository.getAllPaymentMethods(enterpriseId) as List;
    final paymentMethods = repositoryPaymentMethods
        .map((paymentMethodModel) =>
            PaymentMethodModel.toEntityData(paymentMethodModel))
        .toList();
    return paymentMethods;
  }
}
