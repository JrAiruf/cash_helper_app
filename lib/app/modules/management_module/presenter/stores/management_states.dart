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

class GetUsersListFailureState implements ManagementStates {}
