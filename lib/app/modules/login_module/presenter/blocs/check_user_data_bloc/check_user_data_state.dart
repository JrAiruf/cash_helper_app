part of 'check_user_data_bloc.dart';

@immutable
class CheckUserDataStates {}

class CheckUserDataInitialState extends CheckUserDataStates {}

class CheckUserDataLoadingState extends CheckUserDataStates {}

class CheckUserDataFailureState extends CheckUserDataStates {
  final String error;

  CheckUserDataFailureState(this.error);
}

class CheckUserDataSuccessState extends CheckUserDataStates {}
