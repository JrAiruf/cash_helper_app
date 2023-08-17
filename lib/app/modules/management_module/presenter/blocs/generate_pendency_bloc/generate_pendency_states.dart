part of 'generate_pendency_bloc.dart';

@immutable
class GeneratePendencyStates {}

class GeneratePendencyInitialState extends GeneratePendencyStates {}

class GeneratePendencyLoadingState extends GeneratePendencyStates {}

class GeneratePendencyFailureState extends GeneratePendencyStates {
  final String error;

  GeneratePendencyFailureState(this.error);
}

class GeneratePendencySuccessState extends GeneratePendencyStates {}
