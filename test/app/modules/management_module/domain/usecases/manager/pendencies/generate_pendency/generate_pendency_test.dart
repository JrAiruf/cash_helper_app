import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/pendencies/generate_pendency/igenerate_pendency.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';
import 'package:cash_helper_app/app/utils/tests/pendency_test_objects/pendency_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../../../../mocks/mocks.dart';

class GeneratePendencyMock implements IGeneratePendency {
  GeneratePendencyMock({required ManagementRepository repository}) : _repository = repository;
  final ManagementRepository _repository;
  @override
  Future<PendencyEntity>? call(String enterpriseId, String operatorId, String annotationId) async {
    final pendency = await _repository.generatePendency(enterpriseId, operatorId, annotationId);
    if (pendency != null) {
      return pendency;
    } else {
      return PendencyEntity();
    }
  }
}

void main() {
  final repository = ManagementRepoMock();
  final generatePendency = GeneratePendencyMock(repository: repository);
  group(
    "GeneratPendency Usecase should",
    () {
      test(
        'Create a New Pendency',
        () async {
          when(repository.generatePendency(any, any, any)).thenAnswer((_) async => PendencyTestObjects.pendency);
          final result = await generatePendency("enterpriseId", "operatorId", "annotationId");
          expect(result, isA<PendencyEntity>());
          expect(result?.pendencyId != null, equals(true));
        },
      );
      test(
        'Fail to create a New Pendency',
        () async {
          when(repository.generatePendency(any, any, any)).thenAnswer((_) async => null);
          final result = await generatePendency("enterpriseId", "operatorId", "annotationId");
          expect(result, isA<PendencyEntity>());
          expect(result?.pendencyId, equals(null));
        },
      );
    },
  );
}
