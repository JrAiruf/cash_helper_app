abstract class ManagerEvents {}

class GetManagerByIdEvent implements ManagerEvents {
  final String enterpriseId;
  final String managerId;
  final String collection;

  GetManagerByIdEvent(this.enterpriseId, this.managerId, this.collection);
}

class ManagerSignOutEvent implements ManagerEvents {}
