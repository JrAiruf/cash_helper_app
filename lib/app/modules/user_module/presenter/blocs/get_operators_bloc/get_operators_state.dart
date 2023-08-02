part of 'get_operators_bloc.dart';

@immutable
abstract class GetOperatorsState {}

class GetOperatorsInitialState extends GetOperatorsState {}

class GetOperatorsLoadingState extends GetOperatorsState {}

class GetOperatorsSuccessState extends GetOperatorsState {
  final List<OperatorEntity> operators;

  GetOperatorsSuccessState(this.operators);
}

class GetOperatorsFailureState extends GetOperatorsState {}
