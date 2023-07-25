import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';

abstract class PaymentMethodsListStates {}

class PaymentMethodsListInitialState implements PaymentMethodsListStates {}

class PaymentMethodsListLoadingState implements PaymentMethodsListStates {}

class PaymentMethodsListSuccessState implements PaymentMethodsListStates {
  final List<PaymentMethodEntity> paymentMethods;

  PaymentMethodsListSuccessState(this.paymentMethods);
}
class PaymentMethodsListErrorState implements PaymentMethodsListStates {
  final String error;

  PaymentMethodsListErrorState(this.error);
}
