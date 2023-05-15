import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/management_module/external/data/application_management_database.dart';
import 'package:cash_helper_app/app/modules/management_module/external/errors/payment_method_not_created.dart';
import 'package:cash_helper_app/app/modules/management_module/external/errors/payment_methods_list_unnavailable.dart';
import 'package:cash_helper_app/app/modules/management_module/external/errors/users_unavailable_error.dart';
import 'package:cash_helper_app/app/services/encrypter/encrypt_service.dart';
import 'package:cash_helper_app/app/utils/tests/enterprise_test_objects/test_objects.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';
import '../../enterprise_module/external/enterprise_database_test.dart';
import '../../login_module/external/login_database_test.dart';

class ManagementDBMock implements ApplicationManagementDatabase {
  ManagementDBMock({
    required FirebaseFirestore database,
  }) : _database = database;

  final FirebaseFirestore _database;
  var databaseOperatorsMapList = <Map<String, dynamic>>[];
  @override
  Future<List<Map<String, dynamic>>>? getOperatorInformations(
      String? enterpriseId) async {
    try {
      final operatorsCollection = await _database
          .collection("enterprise")
          .doc(enterpriseId)
          .collection("operator")
          .get();
      if (operatorsCollection.docs.isNotEmpty) {
        final databaseMaps =
            operatorsCollection.docs.map((e) => e.data()).toList();
        databaseOperatorsMapList =
            databaseMaps.map((operatorMap) => operatorMap).toList();
        return databaseOperatorsMapList;
      } else {
        throw UsersUnavailableError(
            errorMessage: "Lista de usuários indisponível.");
      }
    } catch (e) {
      throw UsersUnavailableError(errorMessage: e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>>? createNewPaymentMethod(
      String? enterpriseId, Map<String, dynamic>? paymentMethod) async {
    try {
      if (enterpriseId!.isNotEmpty && paymentMethod!.isNotEmpty) {
        final paymentMethodsCollection = _database
            .collection("enterprise")
            .doc(enterpriseId)
            .collection("paymentMethods");
        final newPaymentMethod = await paymentMethodsCollection
            .add(paymentMethod)
            .then((value) async {
          final paymentMethodId = value.id;
          await value.update({"paymentMethodId": paymentMethodId});
          return value.get();
        });
        return newPaymentMethod.data() ?? {};
      } else {
        throw PaymentMethodNotCreated(
            errorMessage: "Erro ao criar método de pagamento");
      }
    } catch (e) {
      throw PaymentMethodNotCreated(errorMessage: e.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>>? getAllPaymentMethods(
      String enterpriseId) async {
    try {
      final paymentMethodsCollection = await _database
          .collection("enterprise")
          .doc(enterpriseId)
          .collection("paymentMethods")
          .get();
      if (enterpriseId.isNotEmpty) {
        final paymentMethodsMapList = paymentMethodsCollection.docs
            .map((paymentMethodDocument) => paymentMethodDocument.data())
            .toList();
        return paymentMethodsMapList;
      } else {
        throw PaymentMethodsListUnnavailable(
            errorMessage: "Métodos de pagamento indisponíveis");
      }
    } catch (e) {
      throw PaymentMethodsListUnnavailable(errorMessage: e.toString());
    }
  }
  
  @override
  Future? removePaymentMethod(String enterpriseId, String paymentMethodId) {
    // TODO: implement removePaymentMethod
    throw UnimplementedError();
  }
}

void main() {
  late MockUser user;
  late MockFirebaseAuth authMock;
  late FakeFirebaseFirestore firebaseMock;
  late ManagementDBMock database;
  late EnterpriseDatabaseMock enterpriseDb;
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
      loginDb = FirebaseDatabaseMock(
        auth: authMock,
        database: firebaseMock,
        encryptService: EncryptService(),
        dataVerifier: DataVerifier(),
        uuid: const Uuid(),
      );
      database = ManagementDBMock(database: firebaseMock);
    },
  );
  group(
    'GetOperatorsInformation Function should',
    () {
      test(
        "Retrieve a List<Map<String,dynamic>> from database",
        () async {
          final createdEnterprise = await enterpriseDb
              .createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap);
          final newOperator = await loginDb.register(
              LoginTestObjects.newOperator,
              createdEnterprise?["enterpriseId"],
              LoginTestObjects.newOperator["businessPosition"]);
          expect(createdEnterprise?.isNotEmpty, equals(true));
          expect(newOperator?.isNotEmpty, equals(true));
          final result = await database
              .getOperatorInformations(createdEnterprise!["enterpriseId"]);
          expect(result, isA<List<Map<String, dynamic>>>());
          expect(
              result?.first["operatorId"], equals(newOperator?["operatorId"]));
        },
      );

      test(
        "Fail to get Operator Map List, passing null/empty string as parameter",
        () async {
          expect(database.getOperatorInformations(""),
              throwsA(isA<UsersUnavailableError>()));
          expect(database.getOperatorInformations(null),
              throwsA(isA<UsersUnavailableError>()));
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
            () async => database.createNewPaymentMethod(
                "", PaymentMethodTestObjects.newPaymentMethodMap),
            throwsA(isA<PaymentMethodNotCreated>()),
          );
          expect(
            () async => database.createNewPaymentMethod(
                null, PaymentMethodTestObjects.newPaymentMethodMap),
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
          expect(() async => database.getAllPaymentMethods(""),
              throwsA(isA<PaymentMethodsListUnnavailable>()));
        },
      );
    },
  );
  group(
    'RemovePaymentMethods Function should',
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
          expect(() async => database.getAllPaymentMethods(""),
              throwsA(isA<PaymentMethodsListUnnavailable>()));
        },
      );
    },
  );
}
