import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/payment_method_model.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/create_new_payment_method/icreate_new_payment_method.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';
import 'package:cash_helper_app/app/utils/tests/enterprise_test_objects/test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';

class CreateNewpaymentMethodMock implements ICreateNewpaymentMethod {
  CreateNewpaymentMethodMock({required ManagementRepository repository})
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

void main() {
  final repository = ManagementRepoMock();
  final createNewpaymentMethod =
      CreateNewpaymentMethodMock(repository: repository);
  test("Call repository to create a new payment method", () async {
    when(repository.createNewPaymentMethod(any, any))
        .thenAnswer((_) async => PaymentMethodTestObjects.paymentMethodModel);
    final result = await createNewpaymentMethod(
        "enterpriseId", PaymentMethodTestObjects.newPaymentMethodEntity);
    expect(result, isA<PaymentMethodEntity>());
  });
}
