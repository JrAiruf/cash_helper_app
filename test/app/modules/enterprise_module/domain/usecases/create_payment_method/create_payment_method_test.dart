import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/domain/usecases/create_payment_method/icreate_payment_method.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/data/enterprise_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../mocks/mocks.dart';

class CreatePaymentMethodMock implements ICreatePaymentMethod {
  CreatePaymentMethodMock({required EnterpriseRepository repository})
      : _repository = repository;

  final EnterpriseRepository _repository;
  @override
  Future<PaymentMethodEntity>? call(PaymentMethodEntity? paymentMethodEntity, String? enterpriseId) async {
    // TODO: implement call
    throw UnimplementedError();
  }
}

void main() {
  final repository = EnterpriseRepoMock();
  final usecase = CreatePaymentMethodMock(repository: repository);
  group('CreatePaymentMethod usecase Should', () {
   test('Call repository to create a payment method and return a PaymentMethodEntity', () async {
    // TODO: Implement test
  });
  test('Fail to return PaymentMethodEntity', () async {
    // TODO: Implement test
  });
  });
  
}
