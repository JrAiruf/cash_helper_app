import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/pendencies/generate_pendency/igenerate_pendency.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class GeneratePendencyMock implements IGeneratePendency {
  GeneratePendencyMock({required ManagementRepository repository}) : _repository = repository;
  final ManagementRepository _repository;
  @override
  Future<PendencyEntity> call(String enterpriseId, String operatorId, String annotationId) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

void main() {
  test('generate pendency ...', () async {
    // TODO: Implement test
  });
}