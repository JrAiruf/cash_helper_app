import '../../../../user_module/domain/entities/operator_entity.dart';

abstract class IRegisterOperator {
  Future<dynamic> call(OperatorEntity? newOperator,String? enterpriseId, String? collection);
}
