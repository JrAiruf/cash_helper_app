import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/domain/usecases/get_enterprise_by_code/iget_enterprise_by_code.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/data/enterprise_repository.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/enterprise_model.dart';
import 'package:cash_helper_app/app/utils/enterprise_test_objects/test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';

class GetEnterpriseByCodeMock implements IGetEnterpriseByCode {
  GetEnterpriseByCodeMock({required EnterpriseRepository repository})
      : _repository = repository;

  final EnterpriseRepository _repository;
  @override
  Future<EnterpriseEntity>? call(String enterpriseCode) async {
    final enterprise = await _repository.getEnterpriseByCode(enterpriseCode);
    return EnterpriseModel.toEntityData(enterprise);
  }
}

void main() {
  late EnterpriseRepoMock repository;
  late GetEnterpriseByCodeMock usecase;
  setUp(() {
    repository = EnterpriseRepoMock();
    usecase = GetEnterpriseByCodeMock(repository: repository);
  });
  test(
    'GetEnterpriseByCode Function should Call Repository to get an enterprise object',
    () async {
    when(repository.getEnterpriseByCode(any))
          .thenAnswer((_) async => EnterpriseTestObjects.enterpriseModel);
      final enterprise = await usecase("enterpriseCode");
      expect(enterprise, isA<EnterpriseEntity>());
      expect(enterprise != null, equals(true));
    },
  );
}
