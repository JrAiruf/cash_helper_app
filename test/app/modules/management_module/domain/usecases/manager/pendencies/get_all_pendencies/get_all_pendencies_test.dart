import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/pendencies/get_all_pendencies/iget_all_pendencies.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';
import 'package:cash_helper_app/app/utils/tests/pendency_test_objects/pendency_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../../../mocks/mocks.dart';

class GetAllPendenciesMock implements IGetAllPendencies {
  GetAllPendenciesMock({required ManagementRepository repository}) : _repository = repository;
  final ManagementRepository _repository;
  @override
  Future<List<PendencyEntity>> call(String enterpriseId) async {
    return await _repository.getAllPendencies(enterpriseId);
  }
}

void main() {
  final repository = ManagementRepoMock();
  final getAllPendencies = GetAllPendenciesMock(repository: repository);
  test("GetAllPendencies Usecase should return a List<PendencyEntity>", () async {
    when(repository.getAllPendencies(any)).thenAnswer(
      (_) async => [
        PendencyTestObjects.pendency,
        PendencyTestObjects.pendency,
      ],
    );
    final result = await getAllPendencies("enterpriseId");
    expect(result, isA<List<PendencyEntity>>());
    expect(result.isNotEmpty, equals(true));
  });
}
