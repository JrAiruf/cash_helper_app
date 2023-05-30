import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/payment_method_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';

abstract class ManagementStates {}

class ManagementInitialState implements ManagementStates {}

class ManagementLoadingState implements ManagementStates {}

class GetUserState implements ManagementStates {}

class GetUserFailureState implements ManagementStates {}

class GetUsersListState implements ManagementStates {
  GetUsersListState({required this.operators});
  final List<OperatorEntity> operators;
}

class NewPaymentMethodState implements ManagementStates {
  NewPaymentMethodState({required this.paymentMethod});
  final PaymentMethodEntity paymentMethod;
}
class GetPaymentMethodsState implements ManagementStates {
  GetPaymentMethodsState({required this.paymentMethods});
  final List<PaymentMethodEntity> paymentMethods;
}

class NoPaymentMethodsState implements ManagementStates {}
class PaymentMethodFailureState implements ManagementStates {}

class GetUsersListFailureState implements ManagementStates {}
