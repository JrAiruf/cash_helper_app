import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/pendencies/get_all_pendencies/iget_all_pendencies.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';
import 'package:flutter_test/flutter_test.dart';


class GetAllPendenciesMock implements IGetAllPendencies {
  GetAllPendenciesMock({required ManagementRepository repository}) : _repository = repository;
 final ManagementRepository _repository;
  @override
  Future<List<PendencyEntity>> call(String enterpriseId) async {
    throw UnimplementedError();
  }
}


void main() {
  test("GetAllPendencies Usecase should return a List<PendencyEntity>", () async {
  });
}