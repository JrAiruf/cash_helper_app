import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';

abstract class OperatorStates {}

class OperatorInitialState implements OperatorStates {}

class OperatorLoadingState implements OperatorStates {}

class OperatorSuccessState implements OperatorStates {
  final OperatorEntity operatorEntity;

  OperatorSuccessState(this.operatorEntity);
}

class OperatorErrorState implements OperatorStates {
  final String error;

  OperatorErrorState(this.error);
}

class OperatorSignOutState implements OperatorStates {}
