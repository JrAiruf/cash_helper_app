import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/external/data/application_enterprise_database.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/data/enterprise_repository.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/enterprise_model.dart';
import 'package:cash_helper_app/app/utils/enterprise_test_objects/test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/mocks.dart';

class EnterpriseRepositoryMock implements EnterpriseRepository {
  EnterpriseRepositoryMock({
    required ApplicationEnterpriseDatabase database,
    required DataVerifier dataVerifier,
  })  : _database = database,
        _dataVerifier = dataVerifier;

  final ApplicationEnterpriseDatabase _database;
  final DataVerifier _dataVerifier;

  @override
  Future? createEnterpriseAccount(EnterpriseModel? enterpriseModel) {
    // TODO: implement call
    throw UnimplementedError();
  }

  @override
  Future getEnterpriseByCode(String? enterpriseCode) {
    // TODO: implement getEnterpriseByCode
    throw UnimplementedError();
  }
}

void main() {
  late EnterpriseRepositoryMock repository;
  late ApplicationEnterpriseDatabase database;
  late DataVerifier dataVerifier;
  setUp(() {
    database = EnterpriseDBMock();
    dataVerifier = DataVerifier();
    repository = EnterpriseRepositoryMock(
        database: database, dataVerifier: dataVerifier);
  });
  group(
    "CreateEnterpriseAccount Function should",
    () {
      test(
        'Call database function to create an enterprise account, and verify function parameters',
        () async {
          when(database
                  .createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap))
              .thenAnswer((_) async => null);
          final createdEnterprise = await repository
              .createEnterpriseAccount(EnterpriseTestObjects.enterpriseModel);
          expect(createdEnterprise, isA<EnterpriseModel>());
          expect(createdEnterprise != null, equals(true));
        },
      );
      test(
        'Fail with invalid parameters',
        () async {
          final createdEnterprise =
              await repository.createEnterpriseAccount(null);
          expect(createdEnterprise == null, equals(true));
        },
      );
    },
  );
  test(
    'enterprise repository impl ...',
    () async {
      // TODO: Implement test
    },
  );
}
