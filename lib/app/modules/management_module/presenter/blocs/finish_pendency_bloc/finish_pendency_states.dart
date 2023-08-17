part of 'finish_pendency_bloc.dart';

@immutable
abstract class FinishPendencyStates {}

class FinishPendencyInitialState extends FinishPendencyStates {}

class FinishPendencyLoadingState extends FinishPendencyStates {}

class FinishPendencyFailureState extends FinishPendencyStates {
  final String error;

  FinishPendencyFailureState(this.error);
}

class FinishPendencySuccessState extends FinishPendencyStates {}
