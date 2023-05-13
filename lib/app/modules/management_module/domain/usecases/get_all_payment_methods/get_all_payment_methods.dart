import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';

import 'iget_all_payment_methods.dart';

class GetAllPaymentMethods implements IGetAllPaymentMethods {
  GetAllPaymentMethods({required ManagementRepository repository})
      : _repository = repository;

  final ManagementRepository _repository;

  @override
  Future? call(String enterpriseId) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
