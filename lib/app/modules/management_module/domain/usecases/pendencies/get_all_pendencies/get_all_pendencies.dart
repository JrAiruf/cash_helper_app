import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';
import 'iget_all_pendencies.dart';

class GetAllPendencies implements IGetAllPendencies {
  GetAllPendencies({required ManagementRepository repository}) : _repository = repository;
  ManagementRepository _repository;
  @override
  Future<List<PendencyEntity>> call(String enterpriseId) async {
    // TODO: implement call
    throw UnimplementedError();
  }
}
