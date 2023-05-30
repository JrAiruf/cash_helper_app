import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/domain/usecases/create_payment_method/icreate_payment_method.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/data/enterprise_repository.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/payment_method_model.dart';
import 'package:cash_helper_app/app/utils/tests/enterprise_test_objects/test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../../mocks/mocks.dart';

class CreatePaymentMethodMock implements ICreatePaymentMethod {
  CreatePaymentMethodMock({required EnterpriseRepository repository})
      : _repository = repository;

  final EnterpriseRepository _repository;
  @override
  Future<PaymentMethodEntity?>? call(
      PaymentMethodEntity? paymentMethodEntity, String? managerCode) async {
    final paymentMethodModel = PaymentMethodModel.fromEntityData(paymentMethodEntity!);
    final repositoryModel = await _repository.createPaymenMethod(paymentMethodModel, managerCode);
      return repositoryModel != null 
      ? PaymentMethodModel.toEntityData(repositoryModel)
      : null;    
  }
}

void main() {
  final repository = EnterpriseRepoMock();
  final usecase = CreatePaymentMethodMock(repository: repository);
  group('CreatePaymentMethod usecase Should', () {
    test(
        'Call repository to create a payment method and return a PaymentMethodEntity',
        () async {
      when(repository.createPaymenMethod(any, any))
          .thenAnswer((_) async => PaymentMethodTestObjects.paymentMethodModel);
      final result = await usecase(
          PaymentMethodTestObjects.newPaymentMethodEntity, "operatorCode");
      expect(result, isA<PaymentMethodEntity>());
      expect(result?.paymentMethodUsingRate, equals(34.7));
    });
    test('Fail to return PaymentMethodEntity', () async {
    });
  });
}
