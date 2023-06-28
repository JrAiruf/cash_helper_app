import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/pendencies/get_pendency_by_id/iget_pendency_by_id.dart';
import '../../../../infra/data/management_repository.dart';

class GetPendencyById implements IGetPendencyById {
  GetPendencyById({required ManagementRepository repository}) : _repository = repository;
 final ManagementRepository _repository;

  @override
  Future<PendencyEntity> call(String enterpriseId, String pendencyId) async {
    // TODO: implement call
    throw UnimplementedError();
  }
}
