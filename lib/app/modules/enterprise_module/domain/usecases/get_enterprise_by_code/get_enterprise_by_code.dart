import 'package:cash_helper_app/app/modules/enterprise_module/domain/usecases/get_enterprise_by_code/iget_enterprise_by_code.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/data/enterprise_repository.dart';

import '../../../infra/models/enterprise_model.dart';
import '../../entities/enterprise_entity.dart';

class GetEnterpriseByCode implements IGetEnterpriseByCode {
  GetEnterpriseByCode({required EnterpriseRepository repository})
      : _repository = repository;

  final EnterpriseRepository _repository;
  @override
  Future<EnterpriseEntity>? call(String enterpriseCode) async {
    final enterprise = await _repository.getEnterpriseByCode(enterpriseCode);
    return EnterpriseModel.toEntityData(enterprise);
  }
}
