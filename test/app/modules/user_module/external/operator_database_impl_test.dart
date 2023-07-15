// ignore_for_file: unused_local_variable

import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/user_module/external/data/operator_database.dart';
import 'package:cash_helper_app/app/modules/user_module/external/errors/operation_errors.dart';
import 'package:cash_helper_app/app/services/encrypter/encrypt_service.dart';
import 'package:cash_helper_app/app/utils/tests/enterprise_test_objects/test_objects.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';
import '../../enterprise_module/external/enterprise_database_test.dart';
import '../../login_module/external/login_database_test.dart';

class OperatorDatabaseMock implements OperatorDatabase {
  OperatorDatabaseMock({required FirebaseAuth auth, required FirebaseFirestore datasource})
      : _auth = auth,
        _datasource = datasource;

  final FirebaseAuth _auth;
  final FirebaseFirestore _datasource;
  final dataVerifier = DataVerifier();
  @override
  Future<void> changeUserEmail(String? newEmail, String? operatorCode, String? operatorPassword, String? collection) async {
    final operatorsCollection = _datasource.collection(collection!);
    if (dataVerifier.validateInputData(inputs: [newEmail, operatorCode, operatorPassword])) {
      final operatorsCollectionDocs = await operatorsCollection.get();
      final databaseOperatorsList = operatorsCollectionDocs.docs.map((databaseOperator) => databaseOperator.data()).toList();
      final operatorToBeDeleted = databaseOperatorsList.firstWhere(
        (operatorMap) {
          return operatorMap["operatorPassword"] == operatorPassword && operatorMap["operatorCode"] == operatorCode;
        },
      );
      await operatorsCollection.doc(operatorToBeDeleted["operatorId"]).update({"operatorEmail": newEmail});
    } else {
      return;
    }
  }

  @override
  Future<void> deleteUserAccount(String? operatorCode, String? operatorEmail, String? operatorPassword, String? collection) async {
    final operatorsCollection = _datasource.collection(collection ?? "");
    if (dataVerifier.validateInputData(inputs: [operatorEmail, operatorCode, operatorPassword, collection])) {
      final operatorsCollectionDocs = await operatorsCollection.get();
      final databaseOperatorsList = operatorsCollectionDocs.docs.map((databaseOperator) => databaseOperator.data()).toList();
      final operatorToBeDeleted = databaseOperatorsList.firstWhere(
        (operatorMap) {
          return operatorMap["operatorPassword"] == operatorPassword && operatorMap["operatorEmail"] == operatorEmail && operatorMap["operatorCode"] == operatorCode;
        },
      );
      await _auth.signInWithEmailAndPassword(email: operatorToBeDeleted["operatorEmail"], password: operatorToBeDeleted["operatorPassword"]);
      await _auth.currentUser?.delete();
      await operatorsCollection.doc(operatorToBeDeleted["operatorId"]).delete();
    } else {
      return;
    }
  }

  @override
  Future<void> changeUserPassword(String? newPassword, String? operatorCode, String? currentPassword, String? collection) async {
    final operatorsCollection = _datasource.collection(collection!);
    if (dataVerifier.validateInputData(inputs: [newPassword, operatorCode, currentPassword])) {
      final operatorsCollectionDocs = await operatorsCollection.get();
      final databaseOperatorsList = operatorsCollectionDocs.docs.map((databaseOperator) => databaseOperator.data()).toList();
      final operatorToBeModified = databaseOperatorsList.firstWhere(
        (operatorMap) {
          return operatorMap["operatorPassword"] == currentPassword && operatorMap["operatorCode"] == operatorCode;
        },
      );
      await _auth.signInWithEmailAndPassword(email: operatorToBeModified["operatorEmail"], password: operatorToBeModified["operatorPassword"]);
      await _auth.currentUser?.updatePassword(newPassword!);
      await operatorsCollection.doc(operatorToBeModified["operatorId"]).update({"operatorPassword": newPassword});
    } else {
      return;
    }
  }

  @override
  Future<void> openOperatorCash(String? enterpriseId, String? operatorId, String? oppeningTime) async {
    final operatorsCollection = _datasource.collection("enterprise").doc(enterpriseId!).collection("operator");
    try {
      if (dataVerifier.validateInputData(inputs: [operatorId, oppeningTime])) {
        await operatorsCollection.doc(operatorId!).update({
          "operatorEnabled": true,
          "operatorOppening": oppeningTime,
          "operatorClosing": "Pendente",
        });
      } else {
        throw OppeningCashError(errorMessage: "Operação não concluída");
      }
    } catch (e) {
      throw OppeningCashError(errorMessage: e.toString());
    }
  }

  @override
  Future<void> closeOperatorCash(String? enterpriseId, String? operatorId, String? closingTime) async {
    try {
      if (dataVerifier.validateInputData(inputs: [enterpriseId, operatorId, closingTime])) {
        final operatorsCollection = _datasource.collection("enterprise").doc(enterpriseId).collection("operator");
        await operatorsCollection.doc(operatorId).update({
          "operatorEnabled": false,
          "operatorClosing": closingTime,
          "operatorOppening": "Pendente",
        });
      } else {
        throw OppeningCashError(errorMessage: "Operação não concluída");
      }
    } on FirebaseException catch (e) {
      throw OppeningCashError(errorMessage: e.toString());
    }
  }
}

void main() {
  final user = MockUser(
    isAnonymous: false,
    uid: 'someuid',
    email: 'email@email.com',
    displayName: 'Junior',
  );
  late MockFirebaseAuth authMock;
  late FakeFirebaseFirestore firebaseMock;
  late FirebaseDatabaseMock loginDatabase;
  late OperatorDatabaseMock database;
  late EnterpriseDatabaseMock enterpriseDatabase;
  setUp(
    () {
      authMock = MockFirebaseAuth(mockUser: user);
      firebaseMock = FakeFirebaseFirestore();
      loginDatabase = FirebaseDatabaseMock(database: firebaseMock, auth: authMock, encryptService: EncryptService(), uuid: const Uuid(), dataVerifier: DataVerifier());
      enterpriseDatabase = EnterpriseDatabaseMock(database: firebaseMock, auth: authMock, uuid: const Uuid());
      database = OperatorDatabaseMock(auth: authMock, datasource: firebaseMock);
    },
  );
  group(
    "OpenOperatorCash should",
    () {
      test(
        "Change operator enabled status from false to true",
        () async {
          await enterpriseDatabase.createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap);
          final enterprisesList = await firebaseMock.collection("enterprise").get();
          final createdEnterprise = enterprisesList.docs.first.data();
          final createdOperator = await loginDatabase.register(LoginTestObjects.newOperator, createdEnterprise["enterpriseId"], LoginTestObjects.newOperator["businessPosition"]);
          await database.openOperatorCash(createdEnterprise["enterpriseId"], createdOperator?["operatorId"], "Now");
          final operatorCollection = await firebaseMock.collection("enterprise").doc(createdEnterprise["enterpriseId"]).collection("operator").get();
          final enabledOperator = operatorCollection.docs.firstWhere((element) => element["operatorEnabled"] == true).data();
          expect(enabledOperator, isA<Map<String, dynamic>>());
          expect(enabledOperator["operatorId"], equals(createdOperator?["operatorId"]));
          expect(enabledOperator["operatorEnabled"], equals(true));
          expect(enabledOperator["operatorOppening"], equals("Now"));
        },
      );
      test(
        'Fail to enable operator status',
        () async {
          expect(database.openOperatorCash("enterpriseId", "", "Now"), throwsA(isA<OppeningCashError>()));
        },
      );
    },
  );
  group(
    "CloseOperatorCash should",
    () {
      test(
        "Change operator enabled status from true to false",
        () async {
          await enterpriseDatabase.createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap);
          final enterprisesList = await firebaseMock.collection("enterprise").get();
          final createdEnterprise = enterprisesList.docs.first.data();
          final createdOperator = await loginDatabase.register(LoginTestObjects.newOperator, createdEnterprise["enterpriseId"], LoginTestObjects.newOperator["businessPosition"]);
          await database.closeOperatorCash(createdEnterprise["enterpriseId"], createdOperator?["operatorId"], "Now");
          final operatorCollection = await firebaseMock.collection("enterprise").doc(createdEnterprise["enterpriseId"]).collection("operator").get();
          final enabledOperator = operatorCollection.docs.firstWhere((element) => element["operatorEnabled"] == false).data();
          expect(enabledOperator, isA<Map<String, dynamic>>());
          expect(enabledOperator["operatorId"], equals(createdOperator?["operatorId"]));
          expect(enabledOperator["operatorEnabled"], equals(false));
          expect(enabledOperator["operatorOppening"], equals("Pendente"));
          expect(enabledOperator["operatorClosing"], equals("Now"));
        },
      );
      test(
        'Fail to disable operator status',
        () async {
          expect(database.openOperatorCash("enterpriseId", "", "Now"), throwsA(isA<OppeningCashError>()));
        },
      );
    },
  );
  /* group(
    'ChangeOperatorEmail should',
    () {
      test(
        'Change the operator e-mail, by a new, valid email, validating the given arguments',
        () async {
          final createdOperator = await loginDatabase.register(
              newOperator, newOperator["operatorOcupation"]);
          await database.changeUserEmail(
              "operator@email.com",
              createdOperator?["operatorCode"],
              createdOperator?["operatorPassword"],
              createdOperator?["operatorOcupation"]);
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
          await database.changeUserEmail(
              "operator@email.com",
              null,
              createdOperator?["operatorPassword"],
              createdOperator?["operatorOcupation"]);
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
          final createdOperator =
              await loginDatabase.register(newOperator, "deleteCollection");
          await database.deleteUserAccount(
              createdOperator?["operatorCode"],
              createdOperator?["operatorEmail"],
              createdOperator?["operatorPassword"],
              "deleteCollection");
          final databaseDocsList =
              await firebaseMock.collection("deleteCollection").get();
          expect(databaseDocsList.docs.length, equals(0));
        },
      );
      test(
        'Fail to delete account',
        () async {
          final createdOperator =
              await loginDatabase.register(newOperator, "otherCollection");
          await database.deleteUserAccount(createdOperator?["operatorCode"],
              null, createdOperator?["operatorPassword"], "otherCollection");
          final databaseDocsList =
              await firebaseMock.collection("otherCollection").get();
          expect(databaseDocsList.docs.length, equals(1));
        },
      );
    },
  );
  group(
    'ChangeOperatorPassword should',
    () {
      test(
        'Change operator password, validating the given arguments',
        () async {
          final createdOperator = await loginDatabase.register(
              newOperator, newOperator["operatorOcupation"]);
          await database.changeUserPassword(
              "newPassword",
              createdOperator?["operatorCode"],
              createdOperator?["operatorPassword"],
              createdOperator?["operatorOcupation"]);
          final databaseDocsList = await firebaseMock
              .collection(createdOperator?["operatorOcupation"])
              .get();
          final operatorsMapList =
              databaseDocsList.docs.map((e) => e.data()).toList();
          final modifiedOperator = operatorsMapList.firstWhere((operatorMap) {
            return operatorMap["operatorCode"] ==
                createdOperator?["operatorCode"];
          });
          expect(modifiedOperator["operatorPassword"], equals("newPassword"));
        },
      );
      test(
        'Fail to change operator password',
        () async {
          final createdOperator = await loginDatabase.register(
              newOperator, newOperator["operatorOcupation"]);
          await database.changeUserPassword(
              "newPassword",
              null,
              createdOperator?["operatorPassword"],
              createdOperator?["operatorOcupation"]);
          final databaseDocsList = await firebaseMock
              .collection(createdOperator?["operatorOcupation"])
              .get();
          final operatorsMapList =
              databaseDocsList.docs.map((e) => e.data()).toList();
          final modifiedOperator = operatorsMapList.firstWhere((operatorMap) {
            return operatorMap["operatorCode"] ==
                createdOperator?["operatorCode"];
          });
          expect(modifiedOperator["operatorPassword"], equals("12345678"));
        },
      );
    },
  );
  
  group(
    'CloseOperatorCash should',
    () {
      test(
        'Change operator enabled status to false',
        () async {
          final createdOperator =
              await loginDatabase.register(newOperator, "operatorsCollection");
          expect(createdOperator?["operatorEnabled"], equals(false));
          await database.openOperatorCash(createdOperator?["operatorId"],
              "operatorsCollection", "Current Time");
          final operatorCollection =
              await firebaseMock.collection("operatorsCollection").get();
          final enabledOperator = operatorCollection.docs.firstWhere(
              (operatorDocMap) =>
                  operatorDocMap.data()["operatorEnabled"] == true);
          expect(enabledOperator.data().isNotEmpty, equals(true));
          expect(enabledOperator.data()["operatorOppening"],
              equals("Current Time"));
          await database.closeOperatorCash(
              createdOperator?["operatorId"], "operatorsCollection");
               final currentOperatorCollection =
              await firebaseMock.collection("operatorsCollection").get();
          final operatorDisabled = currentOperatorCollection.docs.firstWhere(
              (operatorDocMap) =>
                  operatorDocMap.data()["operatorEnabled"] == false);
          expect(operatorDisabled.data()["operatorEnabled"], equals(false));
        },
      );
      test(
        'Fail to disable operator',
        () async {
          final createdOperator =
              await loginDatabase.register(newOperator, "opOcupation");
          expect(createdOperator?["operatorEnabled"], equals(false));
          await database.openOperatorCash(createdOperator?["operatorId"],
              "opOcupation", "Now");
          final operatorCollection = await firebaseMock
              .collection("opOcupation")
              .get();
          final enabledOperator = operatorCollection.docs.firstWhere(
              (operatorDocMap) =>
                  operatorDocMap.data()["operatorEnabled"] == true);
          expect(enabledOperator.data().isNotEmpty, equals(true));
          expect(enabledOperator.data()["operatorOppening"],
              equals("Now"));
          await database.closeOperatorCash(createdOperator?["operatorId"],null);
          final operatorDisabledCollection = await firebaseMock
              .collection("opOcupation")
              .get();
          final disabledOperatorList = operatorDisabledCollection.docs.where(
              (operatorDocMap) =>
                  operatorDocMap.data()["operatorEnabled"] == false).toList();
          expect(disabledOperatorList.isEmpty, equals(true));
        },
      );
    },
  ); */
}
