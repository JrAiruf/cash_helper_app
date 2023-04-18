import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/external/errors/authentication_error.dart';
import 'package:cash_helper_app/app/modules/login_module/external/errors/operator_not_found_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

class FirebaseDatabaseMock implements ApplicationLoginDatabase {
  FirebaseDatabaseMock(
      {required FirebaseFirestore database,
      required FirebaseAuth auth,
      required Uuid uuid})
      : _database = database,
        _auth = auth,
        _uuid = uuid;

  final FirebaseFirestore _database;
  final FirebaseAuth _auth;
  final Uuid _uuid;
  User? _authUser;
  Map<String, dynamic>? operatorData;
  bool _validCredentials(String? email, String? password) {
    return email != null &&
        !email.contains(' ') &&
        email.isNotEmpty &&
        password != null &&
        !password.contains(' ') &&
        password.isNotEmpty;
  }

  bool _validOperatorInformations(String? operatorId, String? collection) {
    return operatorId != null &&
        !operatorId.contains(' ') &&
        operatorId.isNotEmpty &&
        collection != null &&
        !collection.contains(' ') &&
        collection.isNotEmpty;
  }

  bool _validOperatorValues(String? email,String? operatorCode) {
    return email != null && email != ' ' && operatorCode != null && operatorCode.isNotEmpty;
  }

  String _createOperatorCode(String source, int hashSize) {
    final index = source.length ~/ source.length;
    return source.substring(index, index + hashSize);
  }

  @override
  Future<Map<String, dynamic>?>? register(
      Map<String, dynamic>? newOperator, String? collection) async {
    try {
      final userCredentials = await _auth.createUserWithEmailAndPassword(
          email: newOperator?['operatorEmail'] ?? "",
          password: newOperator?['operatorPassword'] ?? "");
      newOperator?["operatorId"] = userCredentials.user?.uid;
      final operatorCodeResource = _uuid.v1();
      final operatorCode = _createOperatorCode(operatorCodeResource, 6);
      newOperator?["operatorCode"] = operatorCode;
      _authUser = userCredentials.user;
      !newOperator!.containsValue("") && newOperator.isNotEmpty
          ? await _database
              .collection(collection ?? "")
              .doc(newOperator["operatorId"])
              .set(newOperator)
          : null;
      userCredentials.user!.uid.isNotEmpty
          ? operatorData = await _database
              .collection(collection!)
              .doc(newOperator["operatorId"])
              .get()
              .then((value) => value.data())
          : operatorData = null;
      return operatorData;
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>?>? login(
      String? email, String? password, String? collection) async {
    try {
      if (_validCredentials(email, password) && collection!.isNotEmpty) {
        final userCredentials = await _auth
            .signInWithEmailAndPassword(email: email!, password: password!)
            .catchError(
          (e) {
            throw AuthenticationError();
          },
        );
        operatorData = await _database
            .collection(collection)
            .doc(userCredentials.user!.uid)
            .get()
            .then((value) => value.data());
        return operatorData;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      Exception(e.toString());
      throw AuthenticationError();
    }
  }

  @override
  Future<Map<String, dynamic>?>? getOperatorById(
      String? operatorId, String? collection) async {
    try {
      if (_validOperatorInformations(operatorId, collection)) {
        final databaseCollection = _database.collection(collection!);
        operatorData = await databaseCollection
            .doc(operatorId)
            .get()
            .then((value) => value.data());
        return operatorData;
      } else {
        return null;
      }
    } catch (e) {
      Exception(e.toString());
      throw OperatorNotFound();
    }
  }

  @override
  Future<bool>? checkOperatorDataForResetPassword(
      String? email, int? cashierNumber, String? collection) async {
    if (email != null && cashierNumber != null && collection != null) {
      final operatorsCollection = await _database.collection(collection).get();
      final checkedOperator = operatorsCollection.docs.firstWhere(
          (operatorMap) =>
              operatorMap.data()["operatorEmail"] == email &&
              operatorMap.data()["operatorNumber"] == cashierNumber);
      return checkedOperator.exists ? true : false;
    } else {
      return false;
    }
  }

  @override
  Future<void>? resetOperatorPassword(
      String? email, String? operatorCode, String? newPassword) async {
    try {
      final operatorsList = await _database.collection("operator").get();
      if (_validOperatorValues(email, operatorCode)) {
        final databaseOperator = operatorsList.docs
            .firstWhere((operator) =>
                operator["operatorEmail"] == email &&
                operator["operatorCode"] == operatorCode)
            .data();
        await login(email, databaseOperator["operatorPassword"], "operator");
        _auth.currentUser?.updatePassword(newPassword!);
        final operatorsCollection = _database.collection("operator");
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
    operatorData?.clear();
  }
}

void main() {
  final user = MockUser(
    isAnonymous: false,
    uid: 'someuid',
    email: 'email@email.com',
    displayName: 'Junior',
  );
  final Map<String, dynamic> newOperator = {
    'operatorId': 'q34u6hu1qeuyoio',
    'operatorNumber': 1,
    'operatorName': 'Josy Kelly',
    'operatorEmail': 'josy@email.com',
    'operatorPassword': '12345678',
    'operatorCode': '123267',
    'operatorOppening': 'operatorOppening',
    'operatorClosing': 'operatorClosing',
    'operatorEnabled': false,
    'operatorOcupation': "operator",
  };
  final Map<String, dynamic> testOperator = {
    'operatorId': 'q34u6hu1qeuyoio',
    'operatorNumber': 1,
    'operatorName': 'Josy Kelly',
    'operatorEmail': 'junior@email.com',
    'operatorPassword': '12345678',
    'operatorCode': '123267',
    'operatorOppening': 'operatorOppening',
    'operatorClosing': 'operatorClosing',
    'operatorEnabled': false,
    'operatorOcupation': "operator",
  };
  final Map<String, dynamic> deletionOperator = {
    'operatorId': 'q34u6hu1qeuyoio',
    'operatorNumber': 1,
    'operatorName': 'Josy Kelly',
    'operatorEmail': 'josy@email.com',
    'operatorPassword': '12345678',
    'operatorCode': '123267',
    'operatorOppening': 'operatorOppening',
    'operatorClosing': 'operatorClosing',
    'operatorEnabled': false,
    'operatorOcupation': "operator",
  };
  final Map<String, dynamic> modifiedUser = {
    'operatorId': 'q34u6hu1qeuyoio',
    'operatorNumber': 14,
    'operatorName': 'Josy Kelly',
    'operatorEmail': '',
    'operatorPassword': '12345678',
    'operatorCode': '123267',
    'operatorOppening': 'operatorOppening',
    'operatorClosing': 'operatorClosing',
    'operatorEnabled': true,
    'operatorOcupation': "Admin",
  };
  final authMock = MockFirebaseAuth(mockUser: user);
  final firebaseMock = FakeFirebaseFirestore();
  final uuid = Uuid();
  final database =
      FirebaseDatabaseMock(database: firebaseMock, auth: authMock, uuid: uuid);
  group(
    "Register function should",
    () {
      test("Create a document in firebase database containing Operator Data",
          () async {
        final createdOperator = await database.register(
            newOperator, newOperator["operatorOcupation"]);
        final result = await firebaseMock
            .collection(newOperator["operatorOcupation"])
            .get();
        expect(result.docs.isEmpty, equals(false));
        expect(createdOperator, isA<Map<String, dynamic>>());
        expect(
            database.operatorData?["operatorEmail"], equals("josy@email.com"));
      });
      test("Fail to create the operator document in firebase", () async {
        final createdOperator =
            await database.register(modifiedUser, "testCollection");
        final result = await firebaseMock.collection("testCollection").get();
        expect(result.docs.isEmpty, equals(true));
        expect(createdOperator == null, equals(true));
      });
    },
  );
  group(
    "Login function should",
    () {
      test(
        "Sign in successfully in the application",
        () async {
          final createdOperator = await database.register(
              newOperator, newOperator["operatorOcupation"]);
          final result = await firebaseMock
              .collection(newOperator["operatorOcupation"])
              .get();
          expect(result.docs.isEmpty, equals(false));
          expect(createdOperator, isA<Map<String, dynamic>>());
          expect(database.operatorData?["operatorEmail"],
              equals("josy@email.com"));
          final loginOperator = await database.login(
              createdOperator?["operatorEmail"],
              createdOperator?["operatorPassword"],
              newOperator["operatorOcupation"]);
          expect(loginOperator?.isNotEmpty, equals(true));
          expect(loginOperator?["operatorOcupation"], equals("operator"));
        },
      );
      test(
        "Fail to sign in",
        () async {
          final createdOperator =
              await database.register(testOperator, "testCollection");
          final result = await firebaseMock.collection("testCollection").get();
          expect(result.docs.isNotEmpty, equals(true));
          expect(createdOperator, isA<Map<String, dynamic>>());
          expect(createdOperator?["operatorEmail"], equals("junior@email.com"));
          final loginOperator = await database.login("", "", "");
          expect(loginOperator, equals(null));
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
          final createdOperator = await database.register(
              newOperator, newOperator["operatorOcupation"]);
          final result = await firebaseMock
              .collection(newOperator["operatorOcupation"])
              .get();
          expect(result.docs.isNotEmpty, equals(true));
          await database.getOperatorById(createdOperator?["operatorId"],
              createdOperator?["operatorOcupation"]);
          expect(database.operatorData != null, equals(true));
        },
      );
      test(
        "Fail returning operator data",
        () async {
          await database.register(
              newOperator, newOperator["operatorOcupation"]);
          final result = await firebaseMock
              .collection(newOperator["operatorOcupation"])
              .get();
          expect(result.docs.isNotEmpty, equals(true));
          final operatorData = await database.getOperatorById(
              "", newOperator["operatorOcupation"]);
          expect(operatorData == null, equals(true));
        },
      );
    },
  );
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
                  createdOperator["operatorNumber"],
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
}
