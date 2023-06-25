import 'package:cash_helper_app/app/modules/management_module/domain/usecases/payment_methods/remove_payment_method/iremove_payment_method.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';
import 'package:cash_helper_app/app/utils/tests/enterprise_test_objects/test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import '../get_all_payment_methods/get_all_payment_methods_test.dart';

class RemovePaymentMethodMock implements IRemovePaymentMethod {
  RemovePaymentMethodMock({required ManagementRepository repository})
      : _repository = repository;
  final ManagementRepository _repository;

  @override
  Future<void>? call(String enterpriseId, String paymentMethodId) async {
    await _repository.removePaymentMethod(enterpriseId, paymentMethodId);
  }
}

void main() {
  final repository = ManagementRepoMock();
  final getAllPaymentMethods = GetAllPaymentMethodsMock(repository: repository);
  final removePaymentMethod = RemovePaymentMethodMock(repository: repository);
  test(
    'RemovePaymentMethod should call repository to remove the selected item from database',
    () async {
      when(repository.getAllPaymentMethods(any)).thenAnswer((_) async => [
            PaymentMethodTestObjects.paymentMethodModel,
            PaymentMethodTestObjects.paymentMethodModel,
            PaymentMethodTestObjects.paymentMethodModel,
          ]);
      final paymentMethodsList = await getAllPaymentMethods("enterpriseId");
      expect(paymentMethodsList?.length, equals(3));
      when(repository.getAllPaymentMethods(any)).thenAnswer((_) async => [
            PaymentMethodTestObjects.paymentMethodModel,
            PaymentMethodTestObjects.paymentMethodModel,
          ]);
      when(repository.removePaymentMethod(any, any)).thenReturn(null);
      await removePaymentMethod("enterpriseId", "paymentMethodId");
       final currentPaymentMethodsList = await getAllPaymentMethods("enterpriseId");
       expect(currentPaymentMethodsList?.length, equals(2));
    },
  );
}
