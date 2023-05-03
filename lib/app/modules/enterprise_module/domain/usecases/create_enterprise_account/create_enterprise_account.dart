import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/domain/usecases/create_enterprise_account/icreate_enterprise_account.dart';

import '../../../infra/data/enterprise_repository.dart';

class CreateEnterpriseAccount implements ICreateEnterpriseAccount {
CreateEnterpriseAccount({required EnterpriseRepository repository})
      : _repository = repository;

  final EnterpriseRepository _repository;
  @override
  Future call(EnterpriseEntity enterpriseEntity) {
    // TODO: implement call
    throw UnimplementedError();
  }
  
}