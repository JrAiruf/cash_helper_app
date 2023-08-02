part of 'operator_oppening_bloc.dart';

@immutable
abstract class OperatorOppeningEvents {}

class OperatorOppeningEvent implements OperatorOppeningEvents {
  final String enterpriseId;
  final OperatorEntity operatorEntity;

  OperatorOppeningEvent(this.enterpriseId, this.operatorEntity);
}
