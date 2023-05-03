import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/domain/usecases/get_enterprise_by_code/iget_enterprise_by_code.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/data/enterprise_repository.dart';

class GetEnterpriseByCode implements IGetEnterpriseByCode {
  GetEnterpriseByCode({required EnterpriseRepository repository})
      : _repository = repository;

  final EnterpriseRepository _repository;
  @override
  Future? call(EnterpriseEntity enterpriseEntity) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
