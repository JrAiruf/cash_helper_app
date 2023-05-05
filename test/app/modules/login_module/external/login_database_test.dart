import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/external/errors/authentication_error.dart';
import 'package:cash_helper_app/app/modules/login_module/external/errors/operator_not_found_error.dart';
import 'package:cash_helper_app/app/utils/tests/enterprise_test_objects/test_objects.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';
import 'package:cash_helper_app/app/helpers/data_verifier.dart';

import '../../enterprise_module/external/enterprise_database_test.dart';

class FirebaseDatabaseMock implements ApplicationLoginDatabase {
  FirebaseDatabaseMock({
    required FirebaseFirestore database,
    required FirebaseAuth auth,
    required Uuid uuid,
    required DataVerifier dataVerifier,
  })  : _database = database,
        _auth = auth,
        _uuid = uuid,
        _dataVerifier = dataVerifier;

  final FirebaseFirestore _database;
  final FirebaseAuth _auth;
  final Uuid _uuid;
  final DataVerifier _dataVerifier;
  User? _authUser;
  Map<String, dynamic> userData = {};
  String _createUserCode(String source, int hashSize) {
    final index = source.length ~/ source.length;
    return source.substring(index, index + hashSize);
  }

  @override
  Future<Map<String, dynamic>?>? register(Map<String, dynamic>? newOperator,
      String? enterpriseId, String? collection) async {
    late String newUserId;
     final operatorCodeResource = _uuid.v1();
      final operatorCode = _createUserCode(operatorCodeResource, 6);
    try {
      final userCredentials = await _auth.createUserWithEmailAndPassword(
          email: newOperator?['managerEmail'] ?? newOperator?['operatorEmail'],
          password:
              newOperator?['managerPassword'] ?? newOperator?['operatorEmail']);
      if (userCredentials.user?.email == newOperator?['managerEmail']) {
        newOperator?["managerId"] = userCredentials.user!.uid;
         newOperator?["managerCode"] = operatorCode;
        newUserId = userCredentials.user!.uid;
      } else if (userCredentials.user?.email == newOperator?['operatorEmail']) {
        newOperator?["operatorId"] = userCredentials.user?.uid;
        newUserId = userCredentials.user!.uid;
      }
      newOperator?["operatorCode"] = operatorCode;
      _authUser = userCredentials.user;
      !newOperator!.containsValue("") && newOperator.isNotEmpty
          ? await _database
              .collection("enterprise")
              .doc(enterpriseId)
              .collection(newOperator["businessPosition"])
              .doc(newUserId)
              .set(newOperator)
          : null;
      userCredentials.user!.uid.isNotEmpty
          ? userData = await _database
              .collection("enterprise")
              .doc(enterpriseId)
              .collection(newOperator["businessPosition"])
              .doc(newUserId)
              .get()
              .then((value) => value.data() ?? {})
          : userData = {};
      return userData;
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>?>? login(String? email, String? password,
      String? enterpriseId, String? collection) async {
    try {
      if (_dataVerifier
          .validateInputData(inputs: [email, password, collection])) {
        _authUser = await _auth
            .signInWithEmailAndPassword(email: email!, password: password!)
            .then((value) => value.user)
            .catchError(
          (e) {
            throw AuthenticationError(message: e.toString());
          },
        );
        userData = await _database
            .collection("enterprise")
            .doc(enterpriseId)
            .collection(collection!)
            .doc(_authUser!.uid)
            .get()
            .then((value) => value.data() ?? {});
        return userData;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      throw AuthenticationError(message: e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>?>? getUserById(
      String? enterpriseId, String? operatorId, String? collection) async {
    try {
      if (_dataVerifier
          .validateInputData(inputs: [enterpriseId, operatorId, collection])) {
        final databaseCollection = _database
            .collection("enterprise")
            .doc(enterpriseId)
            .collection(collection!);
        userData = await databaseCollection
            .doc(operatorId)
            .get()
            .then((value) => value.data() ?? {});
        return userData;
      } else {
        return null;
      }
    } catch (e) {
      throw OperatorNotFound(message: e.toString());
    }
  }

  @override
  Future<bool>? checkOperatorDataForResetPassword(String? email,
      String? operatorCode, String? enterpriseId, String? collection) async {
    if (email != null && operatorCode != null && collection != null) {
      final operatorsCollection = await _database.collection(collection).get();
      final checkedOperator = operatorsCollection.docs.firstWhere(
          (operatorMap) =>
              operatorMap.data()["operatorEmail"] == email &&
              operatorMap.data()["operatorCode"] == operatorCode);
      return checkedOperator.exists ? true : false;
    } else {
      return false;
    }
  }

  @override
  Future<void>? resetOperatorPassword(String? email, String? operatorCode,
      String? enterpriseId, String? newPassword) async {
    try {
      final operatorsList = await _database.collection("operator").get();
      if (_dataVerifier.validateInputData(inputs: [email, operatorCode])) {
        final databaseOperator = operatorsList.docs
            .firstWhere((operator) =>
                operator["operatorEmail"] == email &&
                operator["operatorCode"] == operatorCode)
            .data();
        /*   await login(email, databaseOperator["operatorPassword"],
            databaseOperator["operatorOcupation"]); */
        await _auth.currentUser?.updatePassword(newPassword!);
        final operatorsCollection =
            _database.collection(databaseOperator["operatorOcupation"]);
        await operatorsCollection
            .doc(databaseOperator["operatorId"])
            .update({"operatorPassword": newPassword!});
      } else {
        return;
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void>? signOut() async {
    await _auth.signOut();
    userData.clear();
  }
}

void main() {
  late MockFirebaseAuth authMock;
  late FakeFirebaseFirestore firebaseMock;
  late Uuid uuid;
  late EnterpriseDatabaseMock enterpriseDatabase;
  late FirebaseDatabaseMock database;
  late DataVerifier dataVerifier;
  setUp(() {
    final user = MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'email@email.com',
      displayName: 'Junior',
    );
    authMock = MockFirebaseAuth(mockUser: user);
    firebaseMock = FakeFirebaseFirestore();
    uuid = const Uuid();
    dataVerifier = DataVerifier();
    enterpriseDatabase = EnterpriseDatabaseMock(
        database: firebaseMock, auth: authMock, uuid: uuid);
    database = FirebaseDatabaseMock(
        database: firebaseMock,
        auth: authMock,
        uuid: uuid,
        dataVerifier: dataVerifier);
  });
  group(
    "Register function should",
    () {
      test("Create an operator in database", () async {
        await enterpriseDatabase
            .createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap);
        final enterprisesList =
            await firebaseMock.collection("enterprise").get();
        final createdEnterprise = enterprisesList.docs.first.data();
        final createdOperator = await database.register(
            LoginTestObjects.newOperator,
            createdEnterprise["enterpriseId"],
            LoginTestObjects.newOperator["businessPosition"]);
        final result = await firebaseMock
            .collection("enterprise")
            .doc(createdEnterprise["enterpriseId"])
            .collection(createdOperator?["businessPosition"])
            .get();
        expect(result.docs.isEmpty, equals(false));
        expect(createdOperator, isA<Map<String, dynamic>>());
        expect(database.userData["operatorId"] != null, equals(true));
        expect(database.userData["operatorCode"] != null, equals(true));
      });
      test("Fail to create the operator document in firebase", () async {
        final createdOperator = await database.register(
            LoginTestObjects.modifiedUser, "", "testCollection");
        final result = await firebaseMock.collection("enterprise").get();
        expect(result.docs.isEmpty, equals(true));
        expect(createdOperator?.isEmpty, equals(true));
      });
    },
  );
  group("Register function should", () {
    test("Create an manager in database", () async {
      await enterpriseDatabase
          .createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap);
      final enterprisesList = await firebaseMock.collection("enterprise").get();
      final createdEnterprise = enterprisesList.docs.first.data();
      final createdManager = await database.register(
          LoginTestObjects.newManager,
          createdEnterprise["enterpriseId"],
          LoginTestObjects.newManager["businessPosition"]);
      final result = await firebaseMock
          .collection("enterprise")
          .doc(createdEnterprise["enterpriseId"])
          .collection(createdManager?["businessPosition"])
          .get();
      expect(result.docs.isEmpty, equals(false));
      expect(createdManager, isA<Map<String, dynamic>>());
      expect(database.userData["managerId"] != null, equals(true));
      expect(database.userData["managerCode"] != null, equals(true));
    });
    test("Fail to create the operator document in firebase", () async {
      final createdManager = await database.register(
          LoginTestObjects.modifiedUser, "", "testCollection");
      final result = await firebaseMock.collection("enterprise").get();
      expect(result.docs.isEmpty, equals(true));
     expect(createdManager?.isEmpty, equals(true));
    });
  });

  group(
    "Login function should",
    () {
      test(
        "Authenticate an operator and sign in the application",
        () async {
          await enterpriseDatabase
              .createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap);
          final enterprisesList =
              await firebaseMock.collection("enterprise").get();
          final createdEnterprise = enterprisesList.docs.first.data();
          final createdOperator = await database.register(
              LoginTestObjects.newOperator,
              createdEnterprise["enterpriseId"],
              LoginTestObjects.newOperator["businessPosition"]);
          final loginOperator = await database.login(
              createdOperator?["operatorEmail"],
              createdOperator?["operatorPassword"],
              createdEnterprise["enterpriseId"],
              createdOperator?["businessPosition"]);
          expect(loginOperator != null, equals(true));
          expect(loginOperator?["operatorId"] != null, equals(true));
          expect(loginOperator?["businessPosition"], equals("operator"));
        },
      );
      test(
        "Fail to sign in",
        () async {
          await enterpriseDatabase
              .createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap);
          final enterprisesList =
              await firebaseMock.collection("enterprise").get();
          final createdEnterprise = enterprisesList.docs.first.data();
          final createdOperator = await database.register(
              LoginTestObjects.newOperator,
              createdEnterprise["enterpriseId"],
              LoginTestObjects.newOperator["businessPosition"]);
          final loginOperator = await database.login(
              createdOperator?["operatorEmail"], "", "", "");
          expect(loginOperator, equals(null));
        },
      );
    },
  );
  group(
    "Login function should",
    () {
      test(
        "Authenticate a manager and sign in the application",
        () async {
          await enterpriseDatabase
              .createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap);
          final enterprisesList =
              await firebaseMock.collection("enterprise").get();
          final createdEnterprise = enterprisesList.docs.first.data();
          final createdManager = await database.register(
              LoginTestObjects.newManager,
              createdEnterprise["enterpriseId"],
              LoginTestObjects.newManager["businessPosition"]);
          final loginOperator = await database.login(
              createdManager?["managerEmail"],
              createdManager?["managerPassword"],
              createdEnterprise["enterpriseId"],
              createdManager?["businessPosition"]);
          expect(loginOperator != null, equals(true));
          expect(loginOperator?["managerId"] != null, equals(true));
          expect(loginOperator?["businessPosition"], equals("manager"));
        },
      );
    },
  );
  group(
    "GetOperatorById function should",
    () {
      test(
        "Return a Map from firebase containing all operator data",
        () async {
          await enterpriseDatabase
              .createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap);
          final enterprisesList =
              await firebaseMock.collection("enterprise").get();
          final createdEnterprise = enterprisesList.docs.first.data();
          final createdOperator = await database.register(
              LoginTestObjects.newOperator,
              createdEnterprise["enterpriseId"],
              LoginTestObjects.newOperator["businessPosition"]);
          final result = await database.getUserById(
              createdEnterprise["enterpriseId"],
              createdOperator?["operatorId"],
              createdOperator?["businessPosition"]);
          expect(result, isA<Map<String, dynamic>>());
          expect(result?["operatorId"] != null, equals(true));
          expect(database.userData != null, equals(true));
        },
      );
      test(
        "Fail returning operator data",
        () async {
          final operatorData = await database.getUserById(
              "", "", LoginTestObjects.newOperator["businessPosition"]);
          expect(operatorData == null, equals(true));
        },
      );
    },
  );
}
  /* 
  
  group(
    "CheckOperatorDataForResetPassword function should",
    () {
      test(
        "Return true, if parameters matches with database's operator data",
        () async {
          final createdOperator = await database.register(
              newOperator, newOperator["operatorOcupation"]);
          final operatorsList = await firebaseMock
              .collection(newOperator["operatorOcupation"])
              .get();
          expect(operatorsList.docs.isEmpty, equals(false));
          final checkedInformation =
              await database.checkOperatorDataForResetPassword(
                  createdOperator!["operatorEmail"],
                  createdOperator["operatorCode"],
                  createdOperator["operatorOcupation"]);
          expect(checkedInformation, equals(true));
        },
      );
      test(
        "Return false, if parameters does not matches with database's operator data",
        () async {
          final createdOperator = await database.register(
              newOperator, newOperator["operatorOcupation"]);
          final operatorsList = await firebaseMock
              .collection(newOperator["operatorOcupation"])
              .get();
          expect(operatorsList.docs.isEmpty, equals(false));
          final checkedInformation =
              await database.checkOperatorDataForResetPassword(
                  createdOperator?["operatorEmail"],
                  null,
                  createdOperator?["operatorOccupation"]);
          expect(checkedInformation, equals(false));
        },
      );
    },
  );
  group(
    "ResetOperatorPassword function should",
    () {
      test(
        "Reset operator user password",
        () async {
          final createdOperator = await database.register(
              testOperator, testOperator["operatorOcupation"]);
          final operatorsList = await firebaseMock
              .collection(testOperator["operatorOcupation"])
              .get();
          expect(operatorsList.docs.isEmpty, equals(false));
          await database.resetOperatorPassword(
              createdOperator!["operatorEmail"],
              createdOperator["operatorCode"],
              "newPassword");
          final currentOperator = await database.getOperatorById(
              createdOperator["operatorId"],
              createdOperator["operatorOcupation"]);
          expect(currentOperator?["operatorPassword"], equals("newPassword"));
        },
      );
      test(
        "Fail reseting password",
        () async {
          final createdOperator = await database.register(
              testOperator, testOperator["operatorOcupation"]);
          final operatorsList = await firebaseMock
              .collection(testOperator["operatorOcupation"])
              .get();
          expect(operatorsList.docs.isEmpty, equals(false));
          await database.resetOperatorPassword(
              createdOperator!["operatorEmail"], null, null);
          final currentOperator = await database.getOperatorById(
              createdOperator["operatorId"],
              createdOperator["operatorOcupation"]);
          expect(currentOperator?["operatorPassword"], equals("12345678"));
        },
      );
    },
  );
  test(
    "Should clear all operatorData from operator's map and sign out",
    () async {
      final createdOperator = await database.register(
          deletionOperator, deletionOperator["operatorOcupation"]);
      final result = await firebaseMock
          .collection(createdOperator!["operatorOcupation"])
          .get();
      expect(result.docs.isNotEmpty == true, equals(true));
      await database.login(deletionOperator["operatorEmail"],
          newOperator["operatorPassword"], newOperator["operatorOcupation"]);
      expect(database.operatorData?["operatorEmail"], equals("josy@email.com"));
      await database.signOut();
      expect(database.operatorData?["operatorEmail"], equals(null));
    },
  ); 
} */