import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirebaseDatabase implements ApplicationLoginDatabase {
  FirebaseDatabase(
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
      await _auth.createUserWithEmailAndPassword(email: newOperator?['operatorEmail'] ?? "", password: newOperator?['operatorPassword'] ?? "");
      !newOperator!.containsValue("") && newOperator.isNotEmpty
          ? await _database.collection(collection ?? "").doc(newOperator["operatorId"]).set(newOperator)
          : null;
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void>? login(String? email, String? password) {
    // TODO: implement login
    throw UnimplementedError();
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
