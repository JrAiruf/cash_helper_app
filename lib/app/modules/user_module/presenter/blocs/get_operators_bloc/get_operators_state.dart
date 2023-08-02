part of 'get_operators_bloc.dart';

@immutable
abstract class GetOperatorsState {}

class GetOperatorsInitialState extends GetOperatorsState {}
class GetOperatorsLoadingState extends GetOperatorsState {}
class GetOperatorsSuccessState extends GetOperatorsState {}
class GetOperatorsFailureState extends GetOperatorsState {}
