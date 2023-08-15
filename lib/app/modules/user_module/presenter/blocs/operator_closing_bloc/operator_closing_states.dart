part of 'operator_closing_bloc.dart';

@immutable
abstract class OperatorClosingStates {}

class OperatorClosingInitialState extends OperatorClosingStates {}

class OperatorClosingLoadingState extends OperatorClosingStates {}

class OperatorClosingFailureState extends OperatorClosingStates {
  final String error;

  OperatorClosingFailureState(this.error);
}

class OperatorClosingSuccessState extends OperatorClosingStates {}
