import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/external/errors/authentication_error.dart';
import 'package:cash_helper_app/app/modules/login_module/external/errors/oeprator_not_found_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

class FirebaseDatabaseMock implements ApplicationLoginDatabase {
  FirebaseDatabaseMock(
      {required FirebaseFirestore database,
      required FirebaseAuth auth})
      : _database = database,
        _auth = auth;

  final FirebaseFirestore _database;
  final FirebaseAuth _auth;

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

  bool _validOperatorValues(String? email, int? cashierNumber) {
    return email != null && email != ' ' && cashierNumber != null;
  }

  bool _validOperatorData(Map<String, dynamic>? databaseOperator, String? email,
      int? cashierNumber) {
    return databaseOperator?["operatorEmail"] == email &&
        databaseOperator?["operatorPassword"] == cashierNumber;
  }

  @override
  Future<void>? register(
      Map<String, dynamic>? newOperator, String? collection) async {
    try {
      final userCredentials = await _auth.createUserWithEmailAndPassword(
          email: newOperator?['operatorEmail'] ?? "",
          password: newOperator?['operatorPassword'] ?? "");
      newOperator?["operatorId"] = userCredentials.user?.uid;
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
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void>? login(
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
        if (userCredentials.user!.uid.isNotEmpty) {
          operatorData = await _database
              .collection(collection)
              .doc(userCredentials.user!.uid)
              .get()
              .then((value) => value.data());
        }
      } else {
        operatorData = null;
        return;
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
        final operatorDatabaseData = await databaseCollection.doc(operatorId).get();
        operatorData?.addAll(operatorDatabaseData.data() ?? {});
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
      String? email, int? cashierNumber, String? collection) {
    // TODO: implement checkOperatorDataForResetPassword
    throw UnimplementedError();
  }

  @override
  Future<void>? resetOperatorPassword(String? email, int? cashierNumber,
      String? collection, String? newPassword) {
    // TODO: implement resetOperatorPassword
    throw UnimplementedError();
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
    'operatorName': ' Josy Kelly',
    'operatorEmail': 'josy@email.com',
    'operatorPassword': '12345678',
    'operatorOppening': 'operatorOppening',
    'operatorClosing': 'operatorClosing',
    'operatorEnabled': false,
    'operatorOcupation': 'Operator',
  };
  final Map<String, dynamic> modifiedUser = {
    'operatorId': 'q34u6hu1qeuyoio',
    'operatorNumber': 14,
    'operatorName': ' Josy Kelly',
    'operatorEmail': 'josy@email.com',
    'operatorPassword': '12345678',
    'operatorOppening': 'operatorOppening',
    'operatorClosing': 'operatorClosing',
    'operatorEnabled': true,
    'operatorOcupation': 'Admin',
  };
  final authMock = MockFirebaseAuth(mockUser: user);
  final firebaseMock = FakeFirebaseFirestore();
  final database = FirebaseDatabaseMock(
      database: firebaseMock, auth: authMock);
  group(
    "Register function should",
    () {
      test("Create a document in firebase database containing Operator Data",
          () async {
        await database.register(newOperator, newOperator["operatorOcupation"]);
        final result = await firebaseMock
            .collection(newOperator["operatorOcupation"])
            .get();
        expect(result.docs.isEmpty, equals(false));
        expect(database.operatorData?["operatorEmail"], equals("josy@email.com"));
      });
      test("Fail to create the operator document in firebase", () async {
        newOperator["operatorEmail"] = "";
        await database.register(newOperator, "testCollection");
        final result = await firebaseMock.collection("testCollection").get();
        expect(result.docs.isEmpty, equals(true));
      });
    },
  );
  group(
    "Login function should",
    () {
      test(
        "Sign in successfully in the application",
        () async {
          await database.register(
              newOperator, newOperator["operatorOcupation"]);
          final result = await firebaseMock
              .collection(newOperator["operatorOcupation"])
              .get();
          expect(result.docs.isNotEmpty, equals(true));
          expect(database.operatorData?["operatorEmail"], equals("josy@email.com"));
          await database.login(
              database.operatorData?["operatorEmail"],
              database.operatorData?["operatorPassword"],
              newOperator["operatorOcupation"]);
          expect(database.operatorData?.isNotEmpty, equals(true));
          expect(database.operatorData?["operatorOcupation"], equals("Operator"));
        },
      );
      test(
        "Fail to sign in",
        () async {
          await database.register(
              newOperator, newOperator["operatorOcupation"]);
          final result = await firebaseMock
              .collection(newOperator["operatorOcupation"])
              .get();
          expect(result.docs.isNotEmpty, equals(true));
          expect(database.operatorData?["operatorEmail"], equals("josy@email.com"));
          await database.login("", "", "");
          expect(database.operatorData?["operatorEmail"], equals(null));
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
          await database.register(
              newOperator, newOperator["operatorOcupation"]);
          final result = await firebaseMock
              .collection(newOperator["operatorOcupation"])
              .get();
          expect(result.docs.isNotEmpty, equals(true));
          await database.getOperatorById("mock_uid", "testCollection");
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
    "description",
    () {
      test("description", () {});
      test("description", () {});
    },
  );
  group(
    "description",
    () {
      test("description", () {});
      test("description", () {});
    },
  );
  test(
    "Should clear all operatorData from operator's map and sign out",
    () async {
      await database.register(newOperator, newOperator["operatorOcupation"]);
      final result =
          await firebaseMock.collection(newOperator["operatorOcupation"]).get();
      expect(result.docs.isNotEmpty == true, equals(true));
      await database.login(
          "email", "password", newOperator["operatorOcupation"]);
      expect(database.operatorData?["operatorEmail"], equals("josy@email.com"));
      await database.signOut();
      expect(database.operatorData?["operatorEmail"], equals(null));
    },
  );
}
