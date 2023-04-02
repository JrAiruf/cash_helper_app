import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/external/errors/authentication_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

class FirebaseDatabaseMock implements ApplicationLoginDatabase {
  FirebaseDatabaseMock(
      {required FirebaseFirestore database,
      required FirebaseAuth auth,
      required Uuid uuidGenerator})
      : _database = database,
        _auth = auth,
        _uuidGenerator = uuidGenerator;

  final FirebaseFirestore _database;
  final FirebaseAuth _auth;
  final Uuid _uuidGenerator;

  Map<String, dynamic>? userData;
  bool _validCredentials(String? email, String? password) {
    return email != null &&
        !email.contains(' ') &&
        email.isNotEmpty &&
        password != null &&
        !password.contains(' ') &&
        password.isNotEmpty;
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
    newOperator?["operatorId"] = _uuidGenerator.v1();
    try {
      await _auth.createUserWithEmailAndPassword(
          email: newOperator?['operatorEmail'] ?? "",
          password: newOperator?['operatorPassword'] ?? "");
      !newOperator!.containsValue("") && newOperator.isNotEmpty
          ? await _database
              .collection(collection ?? "")
              .doc(newOperator["operatorId"])
              .set(newOperator)
          : null;
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void>? login(String? email, String? password) async {
    try {
      _validCredentials(email, password)
          ? await _auth
              .signInWithEmailAndPassword(email: email!, password: password!)
              .catchError(
              (e) {
                throw AuthenticationError();
              },
            )
          : null;
    } on FirebaseAuthException catch (e) {
      Exception(e.toString());
      throw AuthenticationError();
    }
  }

  @override
  Future<Map<String, dynamic>?>? getOperatorById(String? operatorId) {
    // TODO: implement getOperatorById
    throw UnimplementedError();
  }

  @override
  Future<bool>? checkOperatorDataForResetPassword(
      String? email, int? cashierNumber) {
    // TODO: implement checkOperatorDataForResetPassword
    throw UnimplementedError();
  }

  @override
  Future<void>? resetOperatorPassword(
      String? email, int? cashierNumber, String? newPassword) {
    // TODO: implement resetOperatorPassword
    throw UnimplementedError();
  }

  @override
  Future<void>? signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
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
    'ocupation': 'Operator',
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
    'ocupation': 'Admin',
  };
  final authMock = MockFirebaseAuth(mockUser: user);
  final firebaseMock = FakeFirebaseFirestore();
  const uuid = Uuid();
  final database = FirebaseDatabaseMock(
      database: firebaseMock, auth: authMock, uuidGenerator: uuid);
  group(
    "Register function should",
    () {
      test("Create a document in firebase database(Operator Data)", () async {
        await database.register(newOperator, newOperator["ocupation"]);
        final result =
            await firebaseMock.collection(newOperator["ocupation"]).get();
        final operatorData = result.docs.first.data();
        expect(result.docs.isNotEmpty == true, equals(true));
        expect(operatorData["operatorEmail"], equals("josy@email.com"));
      });
      test("Fail to create the operator document in firebase", () async {
        newOperator["operatorEmail"] = "";
        await database.register(newOperator, "testCollection");
        final result = await firebaseMock.collection("testCollection").get();
        expect(result.docs.isEmpty == true, equals(true));
      });
    },
  );
  group(
    "Login function should",
    () {
      test(
        "Sign in successfully in the application",
        () async {
          await database.register(newOperator, newOperator["ocupation"]);
          final result =
              await firebaseMock.collection(newOperator["ocupation"]).get();
          final operatorData = result.docs.first.data();
          expect(result.docs.isNotEmpty == true, equals(true));
          expect(operatorData["operatorEmail"], equals("josy@email.com"));
          await database.login("email", "password");
          expect(database.userData?["operatorEmail"], equals("josy@email.com"));
        },
      );
      test(
        "Fail to sign in",
        () async {
          await database.register(newOperator, newOperator["ocupation"]);
          final result =
              await firebaseMock.collection(newOperator["ocupation"]).get();
          final operatorData = result.docs.first.data();
          expect(result.docs.isNotEmpty == true, equals(true));
          expect(operatorData["operatorEmail"], equals("josy@email.com"));
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
  group(
    "description",
    () {
      test("description", () {});
      test("description", () {});
    },
  );
}
