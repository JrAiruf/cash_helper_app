import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/management_module/external/data/application_management_database.dart';
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
  ManagementDBMock({required FirebaseFirestore database})
      : _database = database;

  final FirebaseFirestore _database;
  final databaseOperatorsMapList = <Map<String, dynamic>>[];
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
        databaseOperatorsMapList.addAll(databaseMaps);
        return databaseOperatorsMapList;
      } else {
        throw UsersUnavailableError(
            errorMessage: "Lista de usuários indisponível.");
      }
    } catch (e) {
      throw UsersUnavailableError(errorMessage: e.toString());
    }
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
          database: firebaseMock, auth: authMock, uuid: const Uuid());
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
}
