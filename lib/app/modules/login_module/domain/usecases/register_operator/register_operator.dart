import 'package:cash_helper_app/app/modules/login_module/domain/usecases/register_operator/iregister_operator.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';

import '../../../../user_module/infra/models/operator_model.dart';
import '../../../../../helpers/data_verifier.dart';
import '../../../infra/data/login_repository.dart';

class RegisterOperator implements IRegisterOperator {
  RegisterOperator({required LoginRepository repository})
      : _repository = repository;

  final LoginRepository _repository;
  final _dataVerifier = DataVerifier();

  @override
  Future<OperatorEntity?> call(OperatorEntity? newOperator, String? collection) async {
    if (_dataVerifier.validateInputData(inputs: [newOperator?.operatorId, collection])) {
     final operatorModelData = OperatorModel.fromEntityData(newOperator ?? OperatorEntity());
      final operatorModel = await _repository.register(operatorModelData, collection) ?? OperatorModel();
      return OperatorModel.toEntityData(operatorModel);
    } else {
      return null;
  }}
}