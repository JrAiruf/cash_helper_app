import '../../../infra/data/management_repository.dart';
import 'iremove_payment_method.dart';

class RemovePaymentMethod implements IRemovePaymentMethod{
RemovePaymentMethod({required ManagementRepository repository})
      : _repository = repository;
  final ManagementRepository _repository;

  @override
  Future? call(String enterpriseId, String paymentMethodId) {
    // TODO: implement call
    throw UnimplementedError();
  }
  
}