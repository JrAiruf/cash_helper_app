import 'package:cash_helper_app/app/modules/login_module/domain/usecases/register_manager/iregister_manager.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';

import '../../../../user_module/infra/models/manager_model.dart';
import '../../../infra/data/login_repository.dart';

class RegisterManager implements IRegisterManager {
RegisterManager({required LoginRepository repository})
      : _repository = repository;

   final LoginRepository _repository;
    @override
  Future<ManagerEntity?> call(ManagerEntity? newOperator,String? enterpriseId,  String? collection) async {
     final operatorModelData = ManagerModel.fromEntityData(newOperator ?? ManagerEntity());
      final operatorModel = await _repository.register(operatorModelData, enterpriseId, collection) ?? ManagerModel();
      return ManagerModel.toEntityData(operatorModel);
   }
}