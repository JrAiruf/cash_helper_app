// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';

import '../../../user_module/domain/entities/manager_entity.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class RecoveryPasswordState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  LoginSuccessState({required this.operatorEntity});
  final OperatorEntity operatorEntity;
}
class ManagerLoginSuccessState extends LoginStates {
  ManagerLoginSuccessState({required this.managerEntity});
  final ManagerEntity managerEntity;
}

class LoginErrorState extends LoginStates {}
