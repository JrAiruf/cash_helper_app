part of 'operator_oppening_bloc.dart';

@immutable
abstract class OperatorOppeningStates {}

class OperatorOppeningInitialState extends OperatorOppeningStates {}
class OperatorOppeningLoadingState extends OperatorOppeningStates {}
class OperatorOppeningSuccessState extends OperatorOppeningStates {}
class OperatorOppeningFailureState extends OperatorOppeningStates {}
