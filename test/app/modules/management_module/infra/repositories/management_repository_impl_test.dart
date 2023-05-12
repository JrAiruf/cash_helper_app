import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/payment_method_model.dart';
import 'package:cash_helper_app/app/modules/management_module/external/management_database.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/mocks.dart';

class ManagementRepositoryMockImpl implements ManagementRepository {
  ManagementRepositoryMockImpl({
    required ManagementDatabase database,
    required DataVerifier dataVerifier,
  })  : _database = database,
        _dataVerifier = dataVerifier;
  final ManagementDatabase _database;
  final DataVerifier _dataVerifier;

  @override
  Future<List<OperatorModel>>? getOperatorsInformations(
      String? enterpriseId) async {
    final operatorsModelList = <OperatorModel>[];
    if (_dataVerifier.validateInputData(inputs: [enterpriseId])) {
      final databaseOperatorsMapsList =
          await _database.getOperatorInformations(enterpriseId) ?? [];
      for (var operatorMap in databaseOperatorsMapsList) {
        final operatorModel = OperatorModel.fromMap(operatorMap);
        operatorsModelList.add(operatorModel);
      }
    }
    return operatorsModelList;
  }

  @override
  Future? createNewPaymentMethod(String enterpriseId, PaymentMethodModel paymentMethod) {
    // TODO: implement createNewPaymentMethod
    throw UnimplementedError();
  }
}

void main() {
  late ManagementDatabase database;
  late ManagementRepositoryMockImpl repository;
  setUp(() {
    database = ManagementDatabaseMock();
    repository = ManagementRepositoryMockImpl(
        database: database, dataVerifier: DataVerifier());
  });
  group(
    'GetOperatorsInformation Function should',
    () {
      test(
        "Call database to retrieve a List<Map<String,dynamic>> and convert it to a List<OperatorModel>",
        () async {
          when(database.getOperatorInformations(any))
              .thenAnswer((_) async => <Map<String, dynamic>>[
                    LoginTestObjects.newRepositoryOperator,
                    LoginTestObjects.newRepositoryOperator,
                  ]);
          final result =
              await repository.getOperatorsInformations("enterpriseId");
          expect(result, isA<List<OperatorModel>>());
          expect(result?.first.operatorId, equals("q34u6hu1qeuyoio"));
        },
      );
      test(
        "Fail to get Operator Map List, passing empty string as parameter",
        () async {
          when(database.getOperatorInformations(any))
              .thenAnswer((_) async => <Map<String, dynamic>>[
                    LoginTestObjects.newOperator,
                    LoginTestObjects.newOperator,
                  ]);
          final result = await repository.getOperatorsInformations("");
          expect(result, isA<List<OperatorModel>>());
          expect(result?.isEmpty, equals(true));
        },
      );
      test(
        "Fail to get Operator Map List, passing null as parameter",
        () async {
          when(database.getOperatorInformations(any))
              .thenAnswer((_) async => <Map<String, dynamic>>[
                    LoginTestObjects.newOperator,
                    LoginTestObjects.newOperator,
                  ]);
          final result = await repository.getOperatorsInformations(null);
          expect(result, isA<List<OperatorModel>>());
          expect(result?.isEmpty, equals(true));
        },
      );
    },
  );
}
