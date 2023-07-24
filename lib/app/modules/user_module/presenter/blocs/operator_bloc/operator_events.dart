abstract class OperatorEvents {}

class GetOperatorByIdEvent implements OperatorEvents {
  final String enterpriseId;
  final String operatorId;
  final String collection;

  GetOperatorByIdEvent(this.enterpriseId, this.operatorId, this.collection);
}

class OperatorSignOutEvent implements OperatorEvents {}
