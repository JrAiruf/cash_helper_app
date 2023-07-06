import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_all_operators/iget_all_operators.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';

import '../../../../user_module/infra/models/operator_model.dart';
import '../../../infra/data/login_repository.dart';

class GetAllOperators implements IGetAllOperators {
  GetAllOperators({required LoginRepository repository}) : _repository = repository;

  final LoginRepository _repository;
  @override
  Future<List<OperatorEntity>>? call(String? enterpriseId) async {
    final operatorsModelList = await _repository.getAllOperators(enterpriseId!) as List;
    return operatorsModelList.map((operatorModel) => OperatorModel.toEntityData(operatorModel)).toList();
  }
}
