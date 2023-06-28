import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/pendencies/get_pendency_by_id/iget_pendency_by_id.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class GetPendencyByIdMock implements IGetPendencyById {
  GetPendencyByIdMock({required ManagementRepository repository}) : _repository = repository;
  final ManagementRepository _repository;

  @override
  Future<PendencyEntity> call(String enterpriseId, String pendencyId) async {
    throw UnimplementedError();
  }
}

void main() {
  test("GetPendencyById Usecase should return a PendencyEntity", () async {});
}
