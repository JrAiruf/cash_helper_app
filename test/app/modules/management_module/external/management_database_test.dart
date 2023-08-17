import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/annotations_module/external/data/application_annotations_database.dart';
import 'package:cash_helper_app/app/modules/management_module/external/data/application_management_database.dart';
import 'package:cash_helper_app/app/modules/management_module/external/errors/payment_method_not_created.dart';
import 'package:cash_helper_app/app/modules/management_module/external/errors/payment_methods_list_unnavailable.dart';
import 'package:cash_helper_app/app/modules/management_module/external/errors/pendency_error.dart';
import 'package:cash_helper_app/app/modules/management_module/external/errors/pendency_list_error.dart';
import 'package:cash_helper_app/app/modules/management_module/external/errors/remove_payment_method_error.dart';
import 'package:cash_helper_app/app/modules/management_module/external/errors/users_unavailable_error.dart';
import 'package:cash_helper_app/app/services/encrypter/encrypt_service.dart';
import 'package:cash_helper_app/app/utils/tests/annotations_test_objects/test_objects.dart';
import 'package:cash_helper_app/app/utils/tests/enterprise_test_objects/test_objects.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:cash_helper_app/app/utils/tests/pendency_test_objects/pendency_test_objects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';
import '../../annotations_module/external/annotations_database_test.dart';
import '../../enterprise_module/external/enterprise_database_test.dart';
import '../../login_module/external/login_database_test.dart';

class ManagementDBMock implements ApplicationManagementDatabase {
  ManagementDBMock({
    required FirebaseFirestore database,
    required ApplicationAnnotationDatabase annotationsDatabase,
  })  : _database = database,
        _annotationsDatabase = annotationsDatabase;

  final FirebaseFirestore _database;
  final ApplicationAnnotationDatabase _annotationsDatabase;

  var databaseOperatorsMapList = <Map<String, dynamic>>[];
  @override
  Future<List<Map<String, dynamic>>>? getOperatorInformations(String? enterpriseId) async {
    try {
      final operatorsCollection = await _database.collection("enterprise").doc(enterpriseId).collection("operator").get();
      if (operatorsCollection.docs.isNotEmpty) {
        final databaseMaps = operatorsCollection.docs.map((e) => e.data()).toList();
        databaseOperatorsMapList = databaseMaps.map((operatorMap) => operatorMap).toList();
        return databaseOperatorsMapList;
      } else {
        throw UsersUnavailableError(errorMessage: "Lista de usuários indisponível.");
      }
    } catch (e) {
      throw UsersUnavailableError(errorMessage: e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>>? createNewPaymentMethod(String? enterpriseId, Map<String, dynamic>? paymentMethod) async {
    try {
      if (enterpriseId!.isNotEmpty && paymentMethod!.isNotEmpty) {
        final paymentMethodsCollection = _database.collection("enterprise").doc(enterpriseId).collection("paymentMethods");
        final newPaymentMethod = await paymentMethodsCollection.add(paymentMethod).then((value) async {
          final paymentMethodId = value.id;
          await value.update({"paymentMethodId": paymentMethodId});
          return value.get();
        });
        return newPaymentMethod.data() ?? {};
      } else {
        throw PaymentMethodNotCreated(errorMessage: "Erro ao criar método de pagamento");
      }
    } catch (e) {
      throw PaymentMethodNotCreated(errorMessage: e.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>>? getAllPaymentMethods(String enterpriseId) async {
    try {
      final paymentMethodsCollection = await _database.collection("enterprise").doc(enterpriseId).collection("paymentMethods").get();
      if (enterpriseId.isNotEmpty) {
        final paymentMethodsMapList = paymentMethodsCollection.docs.map((paymentMethodDocument) => paymentMethodDocument.data()).toList();
        return paymentMethodsMapList;
      } else {
        throw PaymentMethodsListUnnavailable(errorMessage: "Métodos de pagamento indisponíveis");
      }
    } catch (e) {
      throw PaymentMethodsListUnnavailable(errorMessage: e.toString());
    }
  }

  @override
  Future<void>? removePaymentMethod(String? enterpriseId, String? paymentMethodId) async {
    try {
      if (paymentMethodId != null) {
        final paymentMethodsCollection = _database.collection("enterprise").doc(enterpriseId).collection("paymentMethods");
        await paymentMethodsCollection.doc(paymentMethodId).delete();
      } else {
        throw RemovePaymentMethodError(errorMessage: "Método não deletado");
      }
    } catch (e) {
      throw RemovePaymentMethodError(
        errorMessage: e.toString(),
      );
    }
  }

  @override
  Future<Map<String, dynamic>?>? generatePendency(String? enterpriseId, Map<String, dynamic>? pendency) async {
    try {
      final pendenciesCollection = _database.collection("enterprise").doc(enterpriseId).collection("pendencies");
      await pendenciesCollection.add(pendency!).then((value) => value.update({"pendencyId": value.id}));
      final pendenciesMapsList = await pendenciesCollection.get();
      final createdPendency =
          pendenciesMapsList.docs.firstWhere((pendency) => pendency.data()["annotationId"] == pendency["annotationId"] && pendency.data()["operatorId"] == pendency["operatorId"]).data();
      if (createdPendency.isEmpty) {
        return {};
      }
      return createdPendency;
    } catch (e) {
      throw PendencyError(errorMessage: e.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>?>? getAllPendencies(String enterpriseId) async {
    try {
      final pendenciesCollection = await _database.collection("enterprise").doc(enterpriseId).collection("pendencies").get();
      final pendenciesList = pendenciesCollection.docs.map((e) => e.data()).toList();
      if (pendenciesList.isNotEmpty) {
        return pendenciesList;
      } else {
        throw PendencyListError(errorMessage: "Não existem pendências no momento");
      }
    } catch (e) {
      throw PendencyListError(errorMessage: e.toString());
    }
  }

  @override
  Future<void>? finishPendency(String? enterpriseId, String? pendencyId) async {
    try {
      await _database.collection("enterprise").doc(enterpriseId).collection("pendencies").doc(pendencyId).update({"pendencyFinished": true});
    } catch (e) {
      throw PendencyError(errorMessage: e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>>? getPendencyById(String enterpriseId, String pendencyId) async {
    try {
      final pendenciesCollection = await _database.collection("enterprise").doc(enterpriseId).collection("pendencies").get();
      final pendenciesListMap = pendenciesCollection.docs.map((document) => document.data()).toList();
      final currentPendency = pendenciesListMap.firstWhere((pendencyMap) => pendencyMap["pendencyId"] == pendencyId);
      return currentPendency;
    } catch (e) {
      throw PendencyError(errorMessage: e.toString());
    }
  }

  String _getPendencyPeriod(String annotationSaleTime) {
    final annotationPeriod = annotationSaleTime.split(":").first;
    final timeValue = int.tryParse(annotationPeriod) ?? 0;
    if (timeValue >= 18) {
      return "Noite";
    } else if (timeValue >= 12 && timeValue < 18) {
      return "Tarde";
    } else {
      return "Manhã";
    }
  }
}

void main() {
  late MockUser user;
  late MockFirebaseAuth authMock;
  late FakeFirebaseFirestore firebaseMock;
  late ManagementDBMock database;
  late EnterpriseDatabaseMock enterpriseDb;
  late AFirebaseDatabaseMock annotationsDatabase;
  late FirebaseDatabaseMock loginDb;
  setUp(
    () {
      user = MockUser(
        isAnonymous: false,
        uid: 'someuid',
        email: 'email@email.com',
        displayName: 'Junior',
      );
      firebaseMock = FakeFirebaseFirestore();
      authMock = MockFirebaseAuth(mockUser: user);
      firebaseMock = FakeFirebaseFirestore();
      enterpriseDb = EnterpriseDatabaseMock(
        database: firebaseMock,
        auth: authMock,
        uuid: const Uuid(),
      );
      annotationsDatabase = AFirebaseDatabaseMock(database: firebaseMock, uuidGenertor: const Uuid());
      loginDb = FirebaseDatabaseMock(
        auth: authMock,
        database: firebaseMock,
        encryptService: EncryptService(),
        dataVerifier: DataVerifier(),
        uuid: const Uuid(),
      );
      database = ManagementDBMock(database: firebaseMock, annotationsDatabase: annotationsDatabase);
    },
  );
  group(
    'GetOperatorsInformation Function should',
    () {
      test(
        "Retrieve a List<Map<String,dynamic>> from database",
        () async {
          final createdEnterprise = await enterpriseDb.createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap);
          final newOperator = await loginDb.register(LoginTestObjects.newOperator, createdEnterprise?["enterpriseId"], LoginTestObjects.newOperator["businessPosition"]);
          expect(createdEnterprise?.isNotEmpty, equals(true));
          expect(newOperator?.isNotEmpty, equals(true));
          final result = await database.getOperatorInformations(createdEnterprise!["enterpriseId"]);
          expect(result, isA<List<Map<String, dynamic>>>());
          expect(result?.first["operatorId"], equals(newOperator?["operatorId"]));
        },
      );

      test(
        "Fail to get Operator Map List, passing null/empty string as parameter",
        () async {
          expect(database.getOperatorInformations(""), throwsA(isA<UsersUnavailableError>()));
          expect(database.getOperatorInformations(null), throwsA(isA<UsersUnavailableError>()));
        },
      );
    },
  );
  group(
    'CreateNewPaymentMethod Function should',
    () {
      test(
        "Create and save a payment method in database",
        () async {
          final result = await database.createNewPaymentMethod(
            "enterpriseId",
            PaymentMethodTestObjects.newPaymentMethodMap,
          );
          expect(result, isA<Map<String, dynamic>>());
          expect(result?["paymentMethodUsingRate"], equals(34.7));
        },
      );

      test(
        "Fail to create a payment method",
        () async {
          expect(
            () async => database.createNewPaymentMethod("", PaymentMethodTestObjects.newPaymentMethodMap),
            throwsA(isA<PaymentMethodNotCreated>()),
          );
          expect(
            () async => database.createNewPaymentMethod(null, PaymentMethodTestObjects.newPaymentMethodMap),
            throwsA(isA<PaymentMethodNotCreated>()),
          );
        },
      );
    },
  );
  group(
    'GetAllPaymentMethods Function should',
    () {
      test(
        "Get a List of payment methods from database(returns A List<Map<String,dynamic>>)",
        () async {
          await database.createNewPaymentMethod(
            "enterpriseId",
            PaymentMethodTestObjects.newPaymentMethodMap,
          );
          final result = await database.getAllPaymentMethods("enterpriseId");
          expect(result, isA<List<Map<String, dynamic>>>());
          expect(result?.isNotEmpty, equals(true));
        },
      );

      test(
        "Fail to retrive the database list",
        () async {
          expect(() async => database.getAllPaymentMethods(""), throwsA(isA<PaymentMethodsListUnnavailable>()));
        },
      );
    },
  );
  group(
    'RemovePaymentMethods Function should',
    () {
      test(
        "Remove payment methods from database using it's id",
        () async {
          final createdPaymentMethod = await database.createNewPaymentMethod(
            "enterpriseId",
            PaymentMethodTestObjects.newPaymentMethodMap,
          );
          await database.removePaymentMethod("enterpriseId", createdPaymentMethod?["paymentMethodId"]);
          final paymentMethodsList = await database.getAllPaymentMethods("enterpriseId");
          expect(paymentMethodsList?.isEmpty, equals(true));
        },
      );

      test(
        "Fail to retrive the database list",
        () async {
          expect(() async => database.removePaymentMethod("", null), throwsA(isA<RemovePaymentMethodError>()));
        },
      );
    },
  );
  group(
    'GeneratePendency Function should',
    () {
      test(
        "Create a New Pendency in Database",
        () async {
          final createdEnterprise = await enterpriseDb.createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap);
          final result = await database.generatePendency(createdEnterprise?["enterpriseId"], PendencyTestObjects.newPendencyMap);
          expect(result, isA<Map<String, dynamic>>());
          expect(result?["pendencyId"] != null, equals(true));
        },
      );

      test(
        "Fail to create pendencies",
        () async {
          expect(() async => database.generatePendency("", {}), throwsA(isA<PendencyError>()));
        },
      );
    },
  );
  group(
    'GetAllPendencies Function should',
    () {
      test(
        "Get a List of Pendencies in Database",
        () async {
          final createdEnterprise = await enterpriseDb.createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap);
          final newOperator = await loginDb.register(LoginTestObjects.newOperator, createdEnterprise?["enterpriseId"], LoginTestObjects.newOperator["businessPosition"]);
          final annotation = await annotationsDatabase.createAnnotation(createdEnterprise?["enterpriseId"], AnnotationsTestObjects.databaseAnnotation);
          final result = await database.generatePendency(createdEnterprise?["enterpriseId"], PendencyTestObjects.pendencyMap);
          expect(result, isA<Map<String, dynamic>>());
          expect(result?["pendencyId"] != null, equals(true));
          final pendencyList = await database.getAllPendencies(createdEnterprise?["enterpriseId"]);

          expect(pendencyList, isA<List<Map<String, dynamic>>>());
          expect(pendencyList?.isNotEmpty, equals(true));
        },
      );

      test(
        "Fail to Get a List of Pendencies",
        () async {
          expect(() async => database.getAllPendencies(""), throwsA(isA<PendencyListError>()));
        },
      );
    },
  );
  group(
    'FinishPendency Function should',
    () {
      test(
        "Change de Property 'pendencyFinished' to true",
        () async {
          final createdEnterprise = await enterpriseDb.createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap);
          final newOperator = await loginDb.register(LoginTestObjects.newOperator, createdEnterprise?["enterpriseId"], LoginTestObjects.newOperator["businessPosition"]);
          final annotation = await annotationsDatabase.createAnnotation(createdEnterprise?["enterpriseId"], AnnotationsTestObjects.databaseAnnotation);
          final pendency = await database.generatePendency(createdEnterprise?["enterpriseId"], PendencyTestObjects.pendencyMap);

          await database.finishPendency(createdEnterprise?["enterpriseId"], pendency?["pendencyId"]);
          final finishedPendency = await database.getPendencyById(createdEnterprise?["enterpriseId"], pendency?["pendencyId"]);
          expect(finishedPendency?["pendencyFinished"], equals(true));
        },
      );
    },
  );
  group(
    'GetPendencyById Function should',
    () {
      test(
        "retrieve a single map from database",
        () async {
          final createdEnterprise = await enterpriseDb.createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap);
          final newOperator = await loginDb.register(LoginTestObjects.newOperator, createdEnterprise?["enterpriseId"], LoginTestObjects.newOperator["businessPosition"]);
          final annotation = await annotationsDatabase.createAnnotation(createdEnterprise?["enterpriseId"], AnnotationsTestObjects.databaseAnnotation);
          final pendency = await database.generatePendency(createdEnterprise?["enterpriseId"], PendencyTestObjects.pendencyMap);
          final currentPendency = await database.getPendencyById(createdEnterprise?["enterpriseId"], pendency?["pendencyId"]);
          expect(currentPendency?["pendencyId"] != null, equals(true));
        },
      );
    },
  );
  test(
    "Get Pendency day Period",
    () async {
      final result = database._getPendencyPeriod("11:45");
      expect(result, isA<String>());
      expect(result, equals("Manhã"));
    },
  );
}
