import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';

abstract class ManagerStates {}

class ManagerInitialState implements ManagerStates {}

class ManagerLoadingState implements ManagerStates {}

class ManagerSuccessState implements ManagerStates {
  final ManagerEntity manager;

  ManagerSuccessState(this.manager);
}

class ManagerErrorState implements ManagerStates {
  final String error;

  ManagerErrorState(this.error);
}

class ManagerSignOutState implements ManagerStates {}