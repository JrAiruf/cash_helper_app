import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';

abstract class CreateOperatorStates {}

class CreateOperatorInitialState implements CreateOperatorStates {}

class CreateOperatorLoadingState implements CreateOperatorStates {}

class CreateOperatorSuccessState implements CreateOperatorStates {
  final OperatorEntity operatorEntity;

  CreateOperatorSuccessState(this.operatorEntity);
}

class CreateOperatorErrorState implements CreateOperatorStates {
  final String error;

  CreateOperatorErrorState(this.error);
}
