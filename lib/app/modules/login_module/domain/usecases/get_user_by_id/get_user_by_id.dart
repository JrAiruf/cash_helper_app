import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_user_by_id/iget_user_by_id.dart';

import '../../../../../helpers/data_verifier.dart';
import '../../../../user_module/infra/models/manager_model.dart';
import '../../../../user_module/infra/models/operator_model.dart';
import '../../../infra/data/login_repository.dart';

class GetUserById implements IGetUserById {
  GetUserById({
    required LoginRepository repository,
    required DataVerifier dataVerifier,
  })  : _repository = repository,
        _dataVerifier = dataVerifier;

  final LoginRepository _repository;
  final DataVerifier _dataVerifier;
  @override
  Future<dynamic> call(
      String? enterpriseId, String? userId, String? collection) async {
    final userModel =
        await _repository.getUserById(enterpriseId, userId, collection);
    if (_dataVerifier.operatorModelVerifier(model: userModel)) {
      return OperatorModel.toEntityData(userModel);
    } else if (_dataVerifier.managerModelVerifier(model: userModel)) {
      return ManagerModel.toEntityData(userModel);
    } else {
      return null;
    }
  }
}
