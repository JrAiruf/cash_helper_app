import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/domain/usecases/create_enterprise_account/icreate_enterprise_account.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/data/enterprise_repository.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/enterprise_model.dart';
import 'package:cash_helper_app/app/utils/enterprise_test_objects/test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';

class CreateEnterpriseAccountMock implements ICreateEnterpriseAccount {
  CreateEnterpriseAccountMock({required EnterpriseRepository repository})
      : _repository = repository;

  final EnterpriseRepository _repository;
  @override
  Future<EnterpriseEntity?>? call(EnterpriseEntity enterpriseEntity) async {
    /* final enterpriseModel = EnterpriseModel.() */
  }
}

void main() {
  late EnterpriseRepoMock repository;
  late CreateEnterpriseAccountMock usecase;
  setUp(() {
    repository = EnterpriseRepoMock();
    usecase = CreateEnterpriseAccountMock(repository: repository);
  });
  group(
    "CreateEnterpriseAccount Function should",
    () {
      test(
        'Call Repository to create an enterprise account',
        () async {
          when(repository.createEnterpriseAccount(any))
              .thenAnswer((_) async => EnterpriseTestObjects.enterpriseModel);
          final enterprise =
              await usecase(EnterpriseTestObjects.enterpriseEntity);
          expect(enterprise, isA<EnterpriseEntity>());
          expect(enterprise != null, equals(true));
        },
      );
      test(
        'Fail to create enterprise account',
        () async {
          // TODO: Implement test
        },
      );
    },
  );
}
