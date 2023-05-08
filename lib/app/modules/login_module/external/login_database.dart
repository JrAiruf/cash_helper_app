import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../../../helpers/data_verifier.dart';
import 'errors/authentication_error.dart';
import 'errors/operator_not_found_error.dart';

class FirebaseDatabase implements ApplicationLoginDatabase {
  FirebaseDatabase({
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
  Map<String, dynamic>? userData;
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
        newUserId = userCredentials.user!.uid;
        newOperator?["managerCode"] = operatorCode;
      } else if (userCredentials.user?.email == newOperator?['operatorEmail']) {
        newOperator?["operatorId"] = userCredentials.user?.uid;
        newUserId = userCredentials.user!.uid;
        newOperator?["operatorCode"] = operatorCode;
      }
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
            .then((value) => value.user);
        if (_authUser?.uid != null) {
          return userData = await _database
              .collection("enterprise")
              .doc(enterpriseId)
              .collection(collection!)
              .doc(_authUser!.uid)
              .get()
              .then((value) => value.data()!);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      print(e.code);
      /*    if (e.toString().contains("null value")) {
        throw AuthenticationError(
            message: "Erro ao logar. Verifique seus dados");
      } else if (e.toString().contains("password")) {
        throw AuthenticationError(
            message: "E-mail ou senha inválidos");
      } else {
        throw UnknowError(message: e.toString());
      } */
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
            .then((value) => value.data());
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
        await login(email, databaseOperator["operatorPassword"], "",
            databaseOperator["operatorOcupation"]);
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
    userData?.clear();
  }
}
