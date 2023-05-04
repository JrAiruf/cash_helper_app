import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/external/data/application_enterprise_database.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/data/enterprise_repository.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/enterprise_model.dart';
import 'package:cash_helper_app/app/utils/tests/enterprise_test_objects/test_objects.dart';
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
  Future<EnterpriseModel?>? createEnterpriseAccount(
      EnterpriseModel? enterpriseModel) async {
    if (_dataVerifier.objectVerifier(object: enterpriseModel?.toMap() ?? {})) {
      final enterpriseDatabaseMap =
          await _database.createEnterpriseAccount(enterpriseModel?.toMap());
      return EnterpriseModel.fromMap(enterpriseDatabaseMap);
    } else {
      return null;
    }
  }

  @override
  Future<EnterpriseModel?>? getEnterpriseByCode(String? enterpriseCode) async {
    if (_dataVerifier.validateInputData(inputs: [enterpriseCode])) {
      final enterpriseDatabaseMap =
          await _database.getEnterpriseByCode(enterpriseCode);
      return EnterpriseModel.fromMap(enterpriseDatabaseMap);
    } else {
      return null;
    }
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
          when(database.createEnterpriseAccount(any))
              .thenAnswer((_) async => EnterpriseTestObjects.enterpriseMap);
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
  group(
    "GetEnterpriseByCode Function should",
    () {
      test(
        'Call database function to return enterprise data, convert it to an EnterpriseModel,and verify function parameters',
        () async {
          when(database.getEnterpriseByCode(any))
              .thenAnswer((_) async => EnterpriseTestObjects.enterpriseMap);
          final retrivedEnterpriseModel =
              await repository.getEnterpriseByCode("enterpriseCode");
          expect(retrivedEnterpriseModel, isA<EnterpriseModel>());
          expect(retrivedEnterpriseModel != null, equals(true));
        },
      );
      test(
        'Fail with invalid parameters',
        () async {
          final retrivedEnterprise = await repository.getEnterpriseByCode(null);
          expect(retrivedEnterprise == null, equals(true));
        },
      );
    },
  );
}
