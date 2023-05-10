import 'package:cash_helper_app/app/modules/management_module/domain/usecases/get_operator_informations/iget_operators_informations.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';

class GetOperatorsInformations implements IGetOperatorsInformations {
  @override
  Future<List<OperatorEntity>>? call(String? enterpriseId) {
    throw UnimplementedError();
  }
}