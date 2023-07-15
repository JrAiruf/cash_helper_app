import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/user_module/external/data/operator_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'errors/operation_errors.dart';

class OperatorDatabaseImpl implements OperatorDatabase {
  OperatorDatabaseImpl({required FirebaseAuth auth, required FirebaseFirestore datasource})
      : _auth = auth,
        _datasource = datasource;

  final FirebaseAuth _auth;
  final FirebaseFirestore _datasource;
  final dataVerifier = DataVerifier();

  @override
  Future changeUserEmail(String? newEmail, String? operatorCode, String? operatorPassword, String? collection) async {
    final operatorsCollection = _datasource.collection(collection!);
    if (dataVerifier.validateInputData(inputs: [newEmail, operatorCode, operatorPassword])) {
      final operatorsCollectionDocs = await operatorsCollection.get();
      final databaseOperatorsList = operatorsCollectionDocs.docs.map((databaseOperator) => databaseOperator.data()).toList();
      final operatorToBeModified = databaseOperatorsList.firstWhere((operatorMap) => operatorMap["operatorPassword"] == operatorPassword && operatorMap["operatorCode"] == operatorCode);
      await _auth
          .signInWithEmailAndPassword(email: operatorToBeModified["operatorEmail"], password: operatorToBeModified["operatorPassword"])
          .then((currentOperator) => currentOperator.user?.updateEmail(newEmail!));
      await operatorsCollection.doc(operatorToBeModified["operatorId"]).update({"operatorEmail": newEmail});
    } else {
      return;
    }
  }

  @override
  Future<void> deleteUserAccount(String? operatorCode, String? operatorEmail, String? operatorPassword, String? collection) async {
    final operatorsCollection = _datasource.collection(collection ?? "");
    if (dataVerifier.validateInputData(inputs: [operatorEmail, operatorCode, operatorPassword])) {
      final operatorsCollectionDocs = await operatorsCollection.get();
      final databaseOperatorsList = operatorsCollectionDocs.docs.map((databaseOperator) => databaseOperator.data()).toList();
      final operatorToBeDeleted = databaseOperatorsList
          .firstWhere((operatorMap) => operatorMap["operatorPassword"] == operatorPassword && operatorMap["operatorEmail"] == operatorEmail && operatorMap["operatorCode"] == operatorCode);
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
