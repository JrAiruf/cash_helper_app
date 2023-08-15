import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/manager/ifinish_pendency.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';
import 'package:cash_helper_app/app/utils/tests/pendency_test_objects/pendency_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import 'pendencies/get_pendency_by_id/get_pendency_by_id_test.dart';

class FinishPendencyMock implements IFinishPendency {
  FinishPendencyMock({required ManagementRepository repository}) : _repository = repository;

  final ManagementRepository _repository;
  @override
  Future<void> call(String enterpriseId, String pendencyId) async {
    await _repository.finishPendency(enterpriseId, pendencyId);
  }
}

void main() {
  late FinishPendencyMock finishPendency;
  late ManagementRepoMock repository;
  late GetPendencyByIdMock getPendencyByIdMock;
  setUp(
    () {
      repository = ManagementRepoMock();
      finishPendency = FinishPendencyMock(repository: repository);
      getPendencyByIdMock = GetPendencyByIdMock(repository: repository);
    },
  );
  test(
    "FinishPendency should modify the property pendencyFinished from the current pendency",
    () async {
      when(repository.getPendencyById(any, any)).thenAnswer((_) async => PendencyTestObjects.finishedPendency);
      when(repository.finishPendency(any, any)).thenReturn(null);
      await finishPendency("enterpriseId", "pendencyId");
      final result = await getPendencyByIdMock("enterpriseId", "pendencyId");
      expect(result, isA<PendencyEntity>());
      expect(result.pendencyFinished, equals(true));
    },
  );
}
