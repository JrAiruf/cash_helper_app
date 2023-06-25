import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/payment_method_model.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/payment_methods/get_all_payment_methods/iget_all_payment_methods.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';
import 'package:cash_helper_app/app/utils/tests/enterprise_test_objects/test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';

class GetAllPaymentMethodsMock implements IGetAllPaymentMethods {
  GetAllPaymentMethodsMock({required ManagementRepository repository})
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

void main() {
  final repository = ManagementRepoMock();
  final getAllPaymentMethods = GetAllPaymentMethodsMock(repository: repository);
  test(
    'Get All Payment Methods Registered',
    () async {
      when(repository.getAllPaymentMethods(any)).thenAnswer((_) async => [
            PaymentMethodTestObjects.paymentMethodModel,
            PaymentMethodTestObjects.paymentMethodModel,
          ]);

      final result = await getAllPaymentMethods("enterpriseId");
      expect(result, isA<List<PaymentMethodEntity>>());
      expect(result?.first.paymentMethodId,
          equals("aldql34hlaky5qi24nlnalnaljq4nal4"));
    },
  );
}
