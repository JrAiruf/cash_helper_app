part of 'operator_closing_bloc.dart';

@immutable
abstract class OperatorClosingEvents {}

class OperatorClosingEvent implements OperatorClosingEvents {
  final String enterpriseId;
  final String operatorId;
  final String closingTime;

  OperatorClosingEvent(this.enterpriseId, this.operatorId, this.closingTime);

}
