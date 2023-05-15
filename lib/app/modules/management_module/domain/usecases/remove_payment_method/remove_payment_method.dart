import '../../../infra/data/management_repository.dart';
import 'iremove_payment_method.dart';

class RemovePaymentMethod implements IRemovePaymentMethod{
RemovePaymentMethod({required ManagementRepository repository})
      : _repository = repository;
  final ManagementRepository _repository;

  @override
  Future<void>? call(String enterpriseId, String paymentMethodId) async {
    await _repository.removePaymentMethod(enterpriseId, paymentMethodId);
  }
  
}