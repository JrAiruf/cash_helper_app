import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';

abstract class PaymentMethodStates {}

class PaymentMethodInitialState implements PaymentMethodStates {}

class PaymentMethodLoadingState implements PaymentMethodStates {}

class PaymentMethodSuccessState implements PaymentMethodStates {
  final PaymentMethodEntity paymentMethod;

  PaymentMethodSuccessState(this.paymentMethod);
}

class PaymentMethodErrorState implements PaymentMethodStates {
  final String error;

  PaymentMethodErrorState(this.error);
}
