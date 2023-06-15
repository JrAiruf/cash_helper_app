import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/user_module/external/data/operator_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'errors/operation_errors.dart';

class OperatorDatabaseImpl implements OperatorDatabase {
  OperatorDatabaseImpl(
      {required FirebaseAuth auth, required FirebaseFirestore datasource})
      : _auth = auth,
        _datasource = datasource;

  final FirebaseAuth _auth;
  final FirebaseFirestore _datasource;
  final dataVerifier = DataVerifier();

  @override
  Future changeUserEmail(String? newEmail, String? operatorCode,
      String? operatorPassword, String? collection) async {
    final operatorsCollection = _datasource.collection(collection!);
    if (_validOperatorData(newEmail, operatorCode, operatorPassword)) {
      final operatorsCollectionDocs = await operatorsCollection.get();
      final databaseOperatorsList = operatorsCollectionDocs.docs
          .map((databaseOperator) => databaseOperator.data())
          .toList();
      final operatorToBeModified = databaseOperatorsList.firstWhere(
          (operatorMap) =>
              operatorMap["operatorPassword"] == operatorPassword &&
              operatorMap["operatorCode"] == operatorCode);
      await _auth
          .signInWithEmailAndPassword(
              email: operatorToBeModified["operatorEmail"],
              password: operatorToBeModified["operatorPassword"])
          .then((currentOperator) =>
              currentOperator.user?.updateEmail(newEmail!));
      await operatorsCollection
          .doc(operatorToBeModified["operatorId"])
          .update({"operatorEmail": newEmail});
    } else {
      return;
    }
  }

  @override
  Future<void> deleteUserAccount(String? operatorCode, String? operatorEmail,
      String? operatorPassword, String? collection) async {
    final operatorsCollection = _datasource.collection(collection ?? "");
    if (_validOperatorData(operatorEmail, operatorCode, operatorPassword)) {
      final operatorsCollectionDocs = await operatorsCollection.get();
      final databaseOperatorsList = operatorsCollectionDocs.docs
          .map((databaseOperator) => databaseOperator.data())
          .toList();
      final operatorToBeDeleted = databaseOperatorsList.firstWhere(
          (operatorMap) =>
              operatorMap["operatorPassword"] == operatorPassword &&
              operatorMap["operatorEmail"] == operatorEmail &&
              operatorMap["operatorCode"] == operatorCode);
      await _auth.signInWithEmailAndPassword(
          email: operatorToBeDeleted["operatorEmail"],
          password: operatorToBeDeleted["operatorPassword"]);
      await _auth.currentUser?.delete();
      await operatorsCollection.doc(operatorToBeDeleted["operatorId"]).delete();
    } else {
      return;
    }
  }

  @override
  Future<void> changeUserPassword(String? newPassword, String? operatorCode,
      String? currentPassword, String? collection) async {
    final operatorsCollection = _datasource.collection(collection!);
    if (_validOperatorData(newPassword, operatorCode, currentPassword)) {
      final operatorsCollectionDocs = await operatorsCollection.get();
      final databaseOperatorsList = operatorsCollectionDocs.docs
          .map((databaseOperator) => databaseOperator.data())
          .toList();
      final operatorToBeModified = databaseOperatorsList.firstWhere(
        (operatorMap) {
          return operatorMap["operatorPassword"] == currentPassword &&
              operatorMap["operatorCode"] == operatorCode;
        },
      );
      await _auth.signInWithEmailAndPassword(
          email: operatorToBeModified["operatorEmail"],
          password: operatorToBeModified["operatorPassword"]);
      await _auth.currentUser?.updatePassword(newPassword!);
      await operatorsCollection
          .doc(operatorToBeModified["operatorId"])
          .update({"operatorPassword": newPassword});
    } else {
      return;
    }
  }

  @override
  Future<void> openOperatorCash(
      String? enterpriseId, String? operatorId, String? oppeningTime) async {
    final operatorsCollection = _datasource
        .collection("enterprise")
        .doc(enterpriseId!)
        .collection("operator");
    try {
      if (dataVerifier.validateInputData(inputs: [operatorId, oppeningTime])) {
        await operatorsCollection.doc(operatorId!).update({
          "operatorEnabled": true,
          "operatorOppening": oppeningTime,
        });
      } else {
        throw OppeningCashError(errorMessage: "Operação não concluída");
      }
    } catch (e) {
      throw OppeningCashError(errorMessage: e.toString());
    }
  }

  @override
  Future<void> closeOperatorCash(String? operatorId, String? collection) async {
    try {
      if (operatorId != null && collection != null) {
        final operatorsCollection = _datasource.collection(collection);
        await operatorsCollection.doc(operatorId).update({
          "operatorEnabled": false,
          "operatorOppening": "Pendente",
        });
      } else {
        return;
      }
    } on FirebaseException catch (e) {
      throw OppeningCashError(errorMessage: e.toString());
    }
  }

  bool _validOperatorData(
          String? newEmail, String? operatorCode, String? operatorPassword) =>
      newEmail != null && operatorCode != null && operatorPassword != null;
}
