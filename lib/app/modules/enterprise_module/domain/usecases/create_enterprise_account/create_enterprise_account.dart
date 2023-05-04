import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/domain/usecases/create_enterprise_account/icreate_enterprise_account.dart';

import '../../../infra/data/enterprise_repository.dart';
import '../../../infra/models/enterprise_model.dart';

class CreateEnterpriseAccount implements ICreateEnterpriseAccount {
CreateEnterpriseAccount({required EnterpriseRepository repository})
      : _repository = repository;

  final EnterpriseRepository _repository;
  @override
  Future<EnterpriseEntity?>? call(EnterpriseEntity enterpriseEntity) async {
    final enterpriseModel = EnterpriseModel.fromEntityData(enterpriseEntity);
    final enterprise = await _repository.createEnterpriseAccount(enterpriseModel);
    return EnterpriseModel.toEntityData(enterprise);
  }
}