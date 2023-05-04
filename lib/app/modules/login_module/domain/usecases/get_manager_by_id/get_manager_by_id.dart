import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_manager_by_id/iget_manager_by_id.dart';

import '../../../../../helpers/data_verifier.dart';
import '../../../../user_module/domain/entities/manager_entity.dart';
import '../../../../user_module/infra/models/manager_model.dart';
import '../../../infra/data/login_repository.dart';

class GetManagerById implements IGetManagerById{
GetManagerById({required LoginRepository repository})
      : _repository = repository;

  final LoginRepository _repository;
   @override
  Future<ManagerEntity?> call(
      String? enterpriseId, String? operatorId, String? collection) async {
    final operatorModel = await _repository.getUserById(enterpriseId, operatorId, collection);
    return ManagerModel.toEntityData(operatorModel ?? ManagerModel());
  }
}