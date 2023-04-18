import 'package:cash_helper_app/app/modules/operator_module/external/data/operator_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

import '../../login_module/external/login_database_test.dart';

class OperatorDatabaseMock implements OperatorDatabase {
  OperatorDatabaseMock(
      {required FirebaseAuth auth, required FirebaseFirestore datasource})
      : _auth = auth,
        _datasource = datasource;

  final FirebaseAuth _auth;
  final FirebaseFirestore _datasource;

  @override
  Future<void> changeOperatorEmail(
      String? newEmail, String? operatorCode, String? operatorPassword, String? collection) async {
    final operatorsCollection = _datasource.collection(collection!);
    if (_validOperatorData(newEmail, operatorCode, operatorPassword)) {
      final operatorsCollectionDocs = await operatorsCollection.get();
      final databaseOperatorsList = operatorsCollectionDocs.docs
          .map((databaseOperator) => databaseOperator.data())
          .toList();
      final operatorToBeDeleted = databaseOperatorsList.firstWhere(
        (operatorMap) {
          return operatorMap["operatorPassword"] == operatorPassword &&
              operatorMap["operatorCode"] == operatorCode;
        },
      );
      await operatorsCollection
          .doc(operatorToBeDeleted["operatorId"])
          .update({"operatorEmail": newEmail});
    } else {
      return;
    }
  }

  @override
  Future<void> deleteOperatorAccount(String? operatorCode, String? newEmail,
      String? operatorPassword, String? collection) async {
    final operatorsCollection = _datasource.collection(collection ?? "");
    if (_validOperatorData(newEmail, operatorCode, operatorPassword)) {
      final operatorsCollectionDocs = await operatorsCollection.get();
      final databaseOperatorsList = operatorsCollectionDocs.docs
          .map((databaseOperator) => databaseOperator.data())
          .toList();
      final operatorToBeDeleted = databaseOperatorsList.firstWhere(
        (operatorMap) {
          return operatorMap["operatorPassword"] == operatorPassword &&
              operatorMap["operatorCode"] == operatorCode;
        },
      );
      await _auth.signInWithEmailAndPassword(
          email: operatorToBeDeleted["operatorEmail"],
          password: operatorToBeDeleted["operatorPassword"]);
      await _auth.currentUser?.delete();
      await operatorsCollection.doc(operatorToBeDeleted["operatorId"]).delete();
    } else {
      return;
    }
  }

  bool _validOperatorData(
          String? newEmail, String? operatorCode, String? operatorPassword) =>
      newEmail != null && operatorCode != null && operatorPassword != null;
}

void main() {
  final user = MockUser(
    isAnonymous: false,
    uid: 'someuid',
    email: 'email@email.com',
    displayName: 'Junior',
  );
  final authMock = MockFirebaseAuth(mockUser: user);
  final firebaseMock = FakeFirebaseFirestore();
  final loginDatabase = FirebaseDatabaseMock(
      auth: authMock, uuid: const Uuid(), database: firebaseMock);
  final database =
      OperatorDatabaseMock(auth: authMock, datasource: firebaseMock);
  final Map<String, dynamic> newOperator = {
    'operatorId': 'q34u6hu1qeuyoio',
    'operatorNumber': 1,
    'operatorName': ' Josy Kelly',
    'operatorEmail': 'josy@email.com',
    'operatorPassword': '12345678',
    'operatorCode': '123267',
    'operatorOppening': 'operatorOppening',
    'operatorClosing': 'operatorClosing',
    'operatorEnabled': false,
    'operatorOcupation': "operator",
  };
  group(
    'ChangeOperatorEmail should',
    () {
      test(
        'Change the operator e-mail, by a new, valid email, validating the given arguments',
        () async {
          final createdOperator = await loginDatabase.register(
              newOperator, newOperator["operatorOcupation"]);
          await database.changeOperatorEmail(
              "operator@email.com",
              createdOperator?["operatorCode"],
              createdOperator?["operatorPassword"],createdOperator?["operatorOcupation"]);
          final databaseDocsList = await firebaseMock
              .collection(createdOperator?["operatorOcupation"])
              .get();
          final operatorsMapList =
              databaseDocsList.docs.map((e) => e.data()).toList();
          final modifiedOperator = operatorsMapList.firstWhere((operatorMap) {
            return operatorMap["operatorPassword"] ==
                    createdOperator?["operatorPassword"] &&
                operatorMap["operatorCode"] == createdOperator?["operatorCode"];
          });

          expect(
              modifiedOperator["operatorEmail"], equals("operator@email.com"));
        },
      );
      test(
        'Fail to change the e-mail',
        () async {
          final createdOperator = await loginDatabase.register(
              newOperator, newOperator["operatorOcupation"]);
          await database.changeOperatorEmail(
              "operator@email.com", null, createdOperator?["operatorPassword"],createdOperator?["operatorOcupation"]);
          final databaseDocsList = await firebaseMock
              .collection(createdOperator?["operatorOcupation"])
              .get();
          final operatorsMapList =
              databaseDocsList.docs.map((e) => e.data()).toList();
          final modifiedOperator = operatorsMapList.firstWhere((operatorMap) {
            return operatorMap["operatorPassword"] ==
                    createdOperator?["operatorPassword"] &&
                operatorMap["operatorCode"] == createdOperator?["operatorCode"];
          });

          expect(modifiedOperator["operatorEmail"], equals("josy@email.com"));
        },
      );
    },
  );
  group(
    'DeleteOperatorAccount should',
    () {
      test(
        'Delete operator account',
        () async {
          final createdOperator = await loginDatabase.register(
              newOperator, "deleteCollection");
          await database.deleteOperatorAccount(
              createdOperator?["operatorCode"],
              createdOperator?["operatorEmail"],
              createdOperator?["operatorPassword"],
              "deleteCollection");
          final databaseDocsList = await firebaseMock
              .collection("deleteCollection")
              .get();
          expect(databaseDocsList.docs.length, equals(0));
        },
      );
      test(
        'Fail to delete account',
        () async {
          final createdOperator = await loginDatabase.register(
              newOperator, "otherCollection");
          await database.deleteOperatorAccount(
              createdOperator?["operatorCode"],
              null,
              createdOperator?["operatorPassword"],
              "otherCollection");
          final databaseDocsList = await firebaseMock
              .collection( "otherCollection")
              .get();
          expect(databaseDocsList.docs.length, equals(1));
        },
      );
    },
  );
}
