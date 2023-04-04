// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessgState extends LoginStates {
  LoginSuccessgState({required this.operatorEntity});
  final OperatorEntity operatorEntity;
}

class LoginErrorState extends LoginStates {}
