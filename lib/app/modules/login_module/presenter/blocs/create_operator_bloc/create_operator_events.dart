import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';

abstract class CreateOperatorEvents {}

class CreateOperatorEvent implements CreateOperatorEvents {
  final String enterpriseId;
  final String collection;
  final OperatorEntity operatorEntity;

  CreateOperatorEvent(this.enterpriseId, this.collection, this.operatorEntity);
}
