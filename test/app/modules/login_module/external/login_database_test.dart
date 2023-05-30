import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/external/errors/authentication_error.dart';
import 'package:cash_helper_app/app/modules/login_module/external/errors/database_error.dart';
import 'package:cash_helper_app/app/modules/login_module/external/errors/user_not_found_error.dart';
import 'package:cash_helper_app/app/modules/login_module/external/errors/registration_error.dart';
import 'package:cash_helper_app/app/services/crypt_serivce.dart';
import 'package:cash_helper_app/app/services/encrypter/encrypt_service.dart';
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
    required ICryptService encryptService,
    required Uuid uuid,
    required DataVerifier dataVerifier,
  })  : _database = database,
        _auth = auth,
        _encryptService = encryptService,
        _uuid = uuid,
        _dataVerifier = dataVerifier;
  final FirebaseFirestore _database;
  final FirebaseAuth _auth;
  final ICryptService _encryptService;
  final Uuid _uuid;
  final DataVerifier _dataVerifier;
  User? _authUser;
  Map<String, dynamic> userData = {};
  String userBusinessPosition = "";

  String _createUserCode(String source, int hashSize) {
    final index = source.length ~/ source.length;
    return source.substring(index, index + hashSize);
  }

  @override
  Future<Map<String, dynamic>>? register(Map<String, dynamic>? newUserMap,
      String? enterpriseId, String? collection) async {
    late String newUserId;
    final userCode = _createUserCode(_uuid.v1(), 6);
    try {
      _authUser = await _auth
          .createUserWithEmailAndPassword(
              email: newUserMap!['${collection}Email'],
              password: newUserMap['${collection}Password'])
          .then((value) => value.user);
      newUserId = _authUser!.uid;
      newUserMap["${collection}Id"] = newUserId;
      newUserMap["${collection}Code"] = userCode;
      newUserMap['${collection}Password'] =
          _encryptService.generateHash(newUserMap['${collection}Password']);
      newUserMap.isNotEmpty &&
              enterpriseId!.isNotEmpty &&
              _authUser!.uid.isNotEmpty
          ? await _database
              .collection("enterprise")
              .doc(enterpriseId)
              .collection(newUserMap["businessPosition"])
              .doc(newUserId)
              .set(newUserMap)
          : null;
      final registeredUsersList = await _database
          .collection("enterprise")
          .doc(enterpriseId)
          .collection(newUserMap["businessPosition"])
          .get();
      userData = registeredUsersList.docs
          .firstWhere(
              (element) => element.data()["${collection}Id"] == newUserId)
          .data();
      return userData;
    } catch (e) {
      if (userData.isEmpty) {
        throw RegistrationError(message: e.toString());
      } else {
        throw DatabaseError(message: e.toString());
      }
    }
  }

  @override
  Future<Map<String, dynamic>>? login(String? email, String? password,
      String? enterpriseId, String? collection) async {
    try {
      _authUser = await _auth
          .signInWithEmailAndPassword(
              email: email ?? "", password: password ?? "")
          .then((value) => value.user);
      final usersMapList = await _database
          .collection("enterprise")
          .doc(enterpriseId)
          .collection(collection!)
          .get();
      userBusinessPosition = usersMapList.docs.isNotEmpty ? collection : "";
      final databaseUsersCollection = await _database
          .collection("enterprise")
          .doc(enterpriseId)
          .collection(userBusinessPosition)
          .get();
      userData = databaseUsersCollection.docs.firstWhere((element) {
        final verifiedHashCode = _encryptService.checkHashCode(
            password!, element["${collection}Password"]);
        return element["${collection}Email"] == email && verifiedHashCode;
      }).data();
      return userData;
    } on FirebaseException catch (e) {
      if (e.code == "wrong-password" || e.code == "user-not-found") {
        throw AuthenticationError(message: e.message!);
      } else {
        throw UserNotFound(message: e.message!);
      }
    } catch (e) {
      throw UserNotFound(message: e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>>? getUserById(
      String? enterpriseId, String? operatorId, String? collection) async {
    try {
      final databaseCollection = await _database
          .collection("enterprise")
          .doc(enterpriseId)
          .collection(collection!)
          .get();
      userData = databaseCollection.docs
          .firstWhere((element) => element["${collection}Id"] == operatorId)
          .data();
      return userData;
    } catch (e) {
      throw UserNotFound(message: e.toString());
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
        encryptService: EncryptService(),
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
        expect(
            () async =>
                database.register(LoginTestObjects.newOperator, "", "operator"),
            throwsA(isA<RegistrationError>()));
      });
    },
  );
  group("Register function should", () {
    test("Create a manager in database", () async {
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
    test("Fail to create the manager document in firebase", () async {
      expect(
          () async =>
              database.register(LoginTestObjects.modifiedUser, "", "manager"),
          throwsA(isA<RegistrationError>()));
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
              "12345678",
              createdEnterprise["enterpriseId"],
              createdOperator?["businessPosition"]);
          expect(loginOperator != null, equals(true));
          expect(loginOperator?["operatorId"] == createdOperator?["operatorId"],
              equals(true));
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
          expect(
              () async =>
                  database.login(createdOperator?["operatorEmail"], "", "", ""),
              throwsA(isA<UserNotFound>()));
        },
      );
      test(
        "Fail to sign in with non-existing user",
        () async {
          expect(() async => database.login("nonUserEmail", "", "", ""),
              throwsA(isA<UserNotFound>()));
        },
      );
      test(
        "Fail to sign in with another enterprise business position",
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
          expect(
              () async => database.login(
                  createdManager?["managerEmail"],
                  createdManager?["managerPassword"],
                  createdEnterprise["enterpriseId"],
                  "otherposition"),
              throwsA(isA<UserNotFound>()));
        },
      );
      test(
        "Fail to sign in with another user password",
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
          expect(
              () async => database.login(
                  createdManager?["managerEmail"],
                  "wrongPassword",
                  createdEnterprise["enterpriseId"],
                  createdManager?["businessPosition"]),
              throwsA(isA<UserNotFound>()));
        },
      );
    },
  );
  test(
    "Authenticate a manager and sign in the application",
    () async {
      await enterpriseDatabase
          .createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap);
      final enterprisesList = await firebaseMock.collection("enterprise").get();
      final createdEnterprise = enterprisesList.docs.first.data();
      final createdManager = await database.register(
          LoginTestObjects.newManager,
          createdEnterprise["enterpriseId"],
          LoginTestObjects.newManager["businessPosition"]);
      final loginOperator = await database.login(
          createdManager?["managerEmail"],
          "123junior456",
          createdEnterprise["enterpriseId"],
          createdManager?["businessPosition"]);
      expect(loginOperator != null, equals(true));
      expect(loginOperator?["managerId"] != null, equals(true));
      expect(loginOperator?["businessPosition"], equals("manager"));
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
          expect(database.userData.isNotEmpty, equals(true));
        },
      );
      test(
        "Return a Map from firebase containing all manager data",
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
          final result = await database.getUserById(
              createdEnterprise["enterpriseId"],
              createdManager?["managerId"],
              createdManager?["businessPosition"]);
          expect(result, isA<Map<String, dynamic>>());
          expect(result?["managerId"] != null, equals(true));
          expect(database.userData.isNotEmpty, equals(true));
        },
      );
      test(
        "Fail returning operator data",
        () async {
          expect(
              () async => database.getUserById(
                  "", "", LoginTestObjects.newOperator["businessPosition"]),
              throwsA(isA<UserNotFound>()));
        },
      );
    },
  );
/*   group(
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
  ); */
  test(
    "Should clear all operatorData from operator's map and sign out",
    () async {
      final createdEnterprise = await enterpriseDatabase
          .createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap);
      final createdOperator = await database.register(
          LoginTestObjects.newOperator,
          createdEnterprise?["enterpriseId"],
          LoginTestObjects.newOperator["businessPosition"]);

      await database.login(
          createdOperator?["operatorEmail"],
          "12345678",
          createdEnterprise?["enterpriseId"],
          createdOperator?["businessPosition"]);
      expect(database.userData["operatorEmail"], equals("josy@email.com"));
      await database.signOut();
      expect(database.userData["operatorEmail"], equals(null));
    },
  );
}
