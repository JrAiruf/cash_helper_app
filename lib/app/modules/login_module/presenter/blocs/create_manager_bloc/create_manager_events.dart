import '../../../../user_module/domain/entities/manager_entity.dart';

abstract class CreateManagerEvents {}

class CreateManagerEvent implements CreateManagerEvents {
  final String enterpriseId;
  final String collection;
  final ManagerEntity manager;

  CreateManagerEvent(this.enterpriseId, this.collection, this.manager);
}
