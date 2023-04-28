import 'package:cash_helper_app/app/modules/login_module/domain/usecases/login/ilogin.dart';

import '../../../../../helpers/data_verifier.dart';
import '../../../../operator_module/domain/entities/operator_entity.dart';
import '../../../../operator_module/infra/models/operator_model.dart';
import '../../../infra/data/login_repository.dart';

class Login implements ILogin {
 Login({required LoginRepository repository})
      : _repository = repository;

  final LoginRepository _repository;
  final _dataVerifier = DataVerifier();

  @override
  Future<OperatorEntity?> call(String? email, String? password, String? collection) async {
 if(_dataVerifier.validateInputData(inputs: [email,password,collection])){
   final operatorModel = await _repository.login(email, password, collection);
      return OperatorModel.toEntityData(operatorModel ?? OperatorModel());
 } else {
  return null;
 }
  }
}