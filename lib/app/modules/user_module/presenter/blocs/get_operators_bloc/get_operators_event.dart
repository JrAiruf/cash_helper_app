part of 'get_operators_bloc.dart';

@immutable
abstract class GetOperatorsEvents {}

class GetOperatorsEvent implements GetOperatorsEvents {
  final String enterpriseId;

  GetOperatorsEvent(this.enterpriseId);
}
