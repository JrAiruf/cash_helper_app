import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'errors/authentication_error.dart';
import 'errors/operator_not_found_error.dart';

class FirebaseDatabase implements ApplicationLoginDatabase {
  FirebaseDatabase(
      {required FirebaseFirestore database, required FirebaseAuth auth})
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
  Future<Map<String, dynamic>?>? register(
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
            .then((value) => value)
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
      String? email, int? cashierNumber, String? newPassword) async {
    try {
      final operatorsList = await _database.collection("operator").get();
      if (_validOperatorValues(email, cashierNumber)) {
        final databaseOperator = operatorsList.docs
            .firstWhere((operator) =>
                operator["operatorEmail"] == email &&
                operator["operatorNumber"] == cashierNumber)
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