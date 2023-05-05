import 'package:cash_helper_app/app/modules/login_module/domain/usecases/login/ilogin.dart';
import '../../../../../helpers/data_verifier.dart';
import '../../../../user_module/infra/models/manager_model.dart';
import '../../../../user_module/infra/models/operator_model.dart';
import '../../../infra/data/login_repository.dart';

class Login implements ILogin {
 Login({
    required LoginRepository repository,
    required DataVerifier dataVerifier,
  }) : _repository = repository,
   _dataVerifier = dataVerifier;

  final LoginRepository _repository;
  final DataVerifier _dataVerifier;

  @override
  Future<dynamic> call(String? email, String? password, String? enterpriseId,
      String? collection) async {
    if (_dataVerifier.validateInputData(
        inputs: [email, password, enterpriseId, collection])) {
      final repositoryModel =
          await _repository.login(email, password, enterpriseId, collection);
      if (_dataVerifier.operatorModelVerifier(model: repositoryModel)) {
        return OperatorModel.toEntityData(repositoryModel ?? OperatorModel());
      } else if (_dataVerifier.managerModelVerifier(model: repositoryModel)) {
        return ManagerModel.toEntityData(repositoryModel ?? ManagerModel());
      }
    } else {
      return null;
    }
  }
}