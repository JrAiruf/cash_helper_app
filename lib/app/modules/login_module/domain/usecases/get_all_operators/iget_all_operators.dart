import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';

abstract class IGetAllOperators {
  Future<List<OperatorEntity>>? call(String enterpriseId);
}
