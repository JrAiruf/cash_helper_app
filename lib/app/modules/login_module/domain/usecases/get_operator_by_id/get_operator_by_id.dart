import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_operator_by_id/iget_operator_by_id.dart';

import '../../../../../helpers/data_verifier.dart';
import '../../../../user_module/domain/entities/operator_entity.dart';
import '../../../../user_module/infra/models/operator_model.dart';
import '../../../infra/data/login_repository.dart';

class GetOperatorById implements IGetOperatorById {
GetOperatorById({required LoginRepository repository})
      : _repository = repository;

  final LoginRepository _repository;
  final _dataVerifier = DataVerifier();
  @override
  Future<OperatorEntity?> call(String? enterpriseId, String? operatorId, String? collection) async {
   if(_dataVerifier.validateInputData(inputs: [operatorId,collection])){
        final operatorModel = await _repository.getUserById(enterpriseId, operatorId, collection);
        return OperatorModel.toEntityData(operatorModel ?? OperatorModel());
   } else {
    return OperatorEntity();
   }
  }
}