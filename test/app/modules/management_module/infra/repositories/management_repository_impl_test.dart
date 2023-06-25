import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/payment_method_model.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/external/errors/pendency_error.dart';
import 'package:cash_helper_app/app/modules/management_module/external/management_database.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/adapters/pendency_adapter.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:cash_helper_app/app/utils/tests/enterprise_test_objects/test_objects.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:cash_helper_app/app/utils/tests/pendency_test_objects/pendency_test_objects.dart';
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
  Future<List<OperatorModel>>? getOperatorsInformations(String? enterpriseId) async {
    final operatorsModelList = <OperatorModel>[];
    if (_dataVerifier.validateInputData(inputs: [enterpriseId])) {
      final databaseOperatorsMapsList = await _database.getOperatorInformations(enterpriseId) ?? [];
      for (var operatorMap in databaseOperatorsMapsList) {
        final operatorModel = OperatorModel.fromMap(operatorMap);
        operatorsModelList.add(operatorModel);
      }
    }
    return operatorsModelList;
  }

  @override
  Future<PaymentMethodModel>? createNewPaymentMethod(String? enterpriseId, PaymentMethodModel paymentMethod) async {
    if (_dataVerifier.validateInputData(inputs: [enterpriseId])) {
      final newPaymentMethod = await _database.createNewPaymentMethod(enterpriseId, paymentMethod.toMap());
      return PaymentMethodModel.fromMap(newPaymentMethod ?? {});
    } else {
      return PaymentMethodModel();
    }
  }

  @override
  Future<List<PaymentMethodModel>>? getAllPaymentMethods(String enterpriseId) async {
    if (_dataVerifier.validateInputData(inputs: [enterpriseId])) {
      final paymentMethodMapList = await _database.getAllPaymentMethods(enterpriseId) as List;
      final paymentMethods = paymentMethodMapList.map((paymentMethodMap) => PaymentMethodModel.fromMap(paymentMethodMap)).toList();
      return paymentMethods;
    } else {
      return [];
    }
  }

  @override
  Future<void>? removePaymentMethod(String? enterpriseId, String? paymentMethodId) async {
    if (_dataVerifier.validateInputData(inputs: [
      enterpriseId,
      paymentMethodId,
    ])) {
      await _database.removePaymentMethod(enterpriseId, paymentMethodId);
    } else {
      return;
    }
  }

  @override
  Future<PendencyEntity?>? generatePendency(String? enterpriseId, String? operatorId, String? annotationId) async {
    try {
      final pendencyMap = await _database.generatePendency(enterpriseId, operatorId, annotationId);
      if (pendencyMap != null) {
        return PendencyAdapter.fromMap(pendencyMap);
      } else {
        throw PendencyError(errorMessage: "Pendência não criada");
      }
    } catch (e) {
      throw PendencyError(errorMessage: e.toString());
    }
  }
}

void main() {
  late ManagementDatabase database;
  late ManagementRepositoryMockImpl repository;
  setUp(() {
    database = ManagementDatabaseMock();
    repository = ManagementRepositoryMockImpl(database: database, dataVerifier: DataVerifier());
  });
  group(
    'GetOperatorsInformation Function should',
    () {
      test(
        "Call database to retrieve a List<Map<String,dynamic>> and convert it to a List<OperatorModel>",
        () async {
          when(database.getOperatorInformations(any)).thenAnswer((_) async => <Map<String, dynamic>>[
                LoginTestObjects.newRepositoryOperator,
                LoginTestObjects.newRepositoryOperator,
              ]);
          final result = await repository.getOperatorsInformations("enterpriseId");
          expect(result, isA<List<OperatorModel>>());
          expect(result?.first.operatorId, equals("q34u6hu1qeuyoio"));
        },
      );
      test(
        "Fail to get Operator Map List, passing empty string as parameter",
        () async {
          when(database.getOperatorInformations(any)).thenAnswer((_) async => <Map<String, dynamic>>[
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
          when(database.getOperatorInformations(any)).thenAnswer((_) async => <Map<String, dynamic>>[
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
  group(
    'CreateNewPaymentMethod Function should',
    () {
      test(
        "Call database to create a  new payment method and convert it to an OperatorModel object",
        () async {
          when(database.createNewPaymentMethod(any, any)).thenAnswer((_) async => PaymentMethodTestObjects.paymentMethodMap);
          final result = await repository.createNewPaymentMethod("enterpriseId", PaymentMethodTestObjects.newPaymentMethodModel);
          expect(result, isA<PaymentMethodModel>());
        },
      );
      test(
        "Fail to create payment method, passing empty string as parameter",
        () async {
          when(database.createNewPaymentMethod(any, any)).thenAnswer((_) async => PaymentMethodTestObjects.paymentMethodMap);
          final result = await repository.createNewPaymentMethod("", PaymentMethodTestObjects.newPaymentMethodModel);
          expect(result, isA<PaymentMethodModel>());
          expect(result?.paymentMethodId, equals(null));
        },
      );
      test(
        "Fail to create payment method, passing null as parameter",
        () async {
          when(database.createNewPaymentMethod(any, any)).thenAnswer((_) async => PaymentMethodTestObjects.paymentMethodMap);
          final result = await repository.createNewPaymentMethod(null, PaymentMethodTestObjects.newPaymentMethodModel);
          expect(result, isA<PaymentMethodModel>());
          expect(result?.paymentMethodId, equals(null));
        },
      );
    },
  );
  group(
    'GetAllPaymentMethods Function should',
    () {
      test(
        "Call database to retrieve a List of payment method and convert it to PaymentMethodModel objects list",
        () async {
          when(database.getAllPaymentMethods(any)).thenAnswer(
            (realInvocation) async => [PaymentMethodTestObjects.paymentMethodMap, PaymentMethodTestObjects.paymentMethodMap],
          );

          final result = await repository.getAllPaymentMethods("enterpriseId");
          expect(result, isA<List<PaymentMethodModel>>());
          expect(result?.first.paymentMethodId, equals("aldql34hlaky5qi24nlnalnaljq4nal4"));
        },
      );
      test(
        "Fail to get and  convert list of payment methods",
        () async {
          when(database.getAllPaymentMethods(any)).thenAnswer(
            (realInvocation) async => [PaymentMethodTestObjects.paymentMethodMap, PaymentMethodTestObjects.paymentMethodMap],
          );

          final result = await repository.getAllPaymentMethods("");
          expect(result, isA<List<PaymentMethodModel>>());
          expect(result?.isEmpty, equals(true));
        },
      );
    },
  );
  group(
    'RemovePaymentMethod Function should',
    () {
      test(
        "Call database to remove a payment method permanently",
        () async {
          when(database.getAllPaymentMethods(any)).thenAnswer(
            (realInvocation) async => [PaymentMethodTestObjects.paymentMethodMap, PaymentMethodTestObjects.paymentMethodMap, PaymentMethodTestObjects.paymentMethodMap],
          );
          final result = await repository.getAllPaymentMethods("enterpriseId");
          expect(result?.first.paymentMethodId, equals("aldql34hlaky5qi24nlnalnaljq4nal4"));
          when(database.removePaymentMethod(any, any)).thenReturn(null);
          when(database.getAllPaymentMethods(any)).thenAnswer(
            (realInvocation) async => [PaymentMethodTestObjects.paymentMethodMap, PaymentMethodTestObjects.paymentMethodMap],
          );
          await repository.removePaymentMethod("enterpriseId", "paymentMethodId");
          final paymentMethodsList = await repository.getAllPaymentMethods("enterpriseId");
          expect(paymentMethodsList?.length, equals(2));
        },
      );
      test(
        "Fail to to remove a payment method",
        () async {
          when(database.getAllPaymentMethods(any)).thenAnswer(
            (realInvocation) async => [
              PaymentMethodTestObjects.paymentMethodMap,
              PaymentMethodTestObjects.paymentMethodMap,
              PaymentMethodTestObjects.paymentMethodMap,
            ],
          );
          when(database.removePaymentMethod(any, any)).thenReturn(null);
          await repository.removePaymentMethod("", null);
          final result = await repository.getAllPaymentMethods("enterpriseId");
          expect(result, isA<List<PaymentMethodModel>>());
          expect(result?.length, equals(3));
        },
      );
    },
  );
  group(
    'GeneratePendency Function should',
    () {
      test(
        "Call database to create a new pendency",
        () async {
          when(database.generatePendency(any, any, any)).thenAnswer((_) async => PendencyTestObjects.pendencyMap);
          final result = await repository.generatePendency("enterpriseId", "operatorId", "annotationId");
          expect(result, isA<PendencyEntity>());
          expect(result!.pendencyId != null, equals(true));
        },
      );
      test(
        "Fail to to create pendency (throws PendencyFailure)",
        () async {
          expect(() async => repository.generatePendency("", null, "annotationId"), throwsA(isA<PendencyError>()));
        },
      );
    },
  );
}
