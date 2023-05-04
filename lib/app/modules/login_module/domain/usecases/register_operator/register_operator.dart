import 'package:cash_helper_app/app/modules/login_module/domain/usecases/register_operator/iregister_operator.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import '../../../../user_module/infra/models/operator_model.dart';
import '../../../infra/data/login_repository.dart';

class RegisterOperator implements IRegisterOperator {
  RegisterOperator({required LoginRepository repository})
      : _repository = repository;

   final LoginRepository _repository;
  @override
  Future<OperatorEntity?> call(OperatorEntity? newOperator,String? enterpriseId,  String? collection) async {
     final operatorModelData = OperatorModel.fromEntityData(newOperator ?? OperatorEntity());
      final operatorModel = await _repository.register(operatorModelData, enterpriseId, collection) ?? OperatorModel();
      return OperatorModel.toEntityData(operatorModel);
   }
}