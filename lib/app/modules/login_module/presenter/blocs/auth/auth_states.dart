import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';

abstract class AuthStates {}

class AuthInitialState implements AuthStates {}

class AuthLoadingState implements AuthStates {}

class AuthOperatorSuccessState implements AuthStates {
  final OperatorEntity cashOperator;

  AuthOperatorSuccessState(this.cashOperator);
}

class AuthManagerSuccessState implements AuthStates {
  final ManagerEntity manager;

  AuthManagerSuccessState(this.manager);
}

class AuthErrorState implements AuthStates {
  final String error;

  AuthErrorState(this.error);
}
