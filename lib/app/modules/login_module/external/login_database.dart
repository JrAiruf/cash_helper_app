import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../../../helpers/data_verifier.dart';
import 'errors/authentication_error.dart';
import 'errors/database_error.dart';
import 'errors/operator_not_found_error.dart';
import 'errors/registration_error.dart';

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
    Map<String, dynamic> userData = {};

  String _createUserCode(String source, int hashSize) {
    final index = source.length ~/ source.length;
    return source.substring(index, index + hashSize);
  }

  @override
  Future<Map<String, dynamic>>? register(Map<String, dynamic> newUserMap,
      String enterpriseId, String collection) async {
    late String newUserId;
    final operatorCode = _createUserCode(_uuid.v1(), 6);
    try {
      _authUser = await _auth
          .createUserWithEmailAndPassword(
              email: newUserMap['${collection}Email'],
              password: newUserMap['${collection}Password'])
          .then((value) => value.user);
      newUserId = _authUser!.uid;
      newUserMap["${collection}Id"] = newUserId;
      newUserMap["${collection}Code"] = operatorCode;
      newUserMap.isNotEmpty &&
              enterpriseId.isNotEmpty &&
              _authUser!.uid.isNotEmpty
          ? await _database
              .collection("enterprise")
              .doc(enterpriseId)
              .collection(newUserMap["businessPosition"])
              .doc(newUserId)
              .set(newUserMap)
          : null;
      final registeredUsersList = await _database
          .collection("enterprise")
          .doc(enterpriseId)
          .collection(newUserMap["businessPosition"])
          .get();
      userData = registeredUsersList.docs
          .firstWhere(
              (element) => element.data()["${collection}Id"] == newUserId)
          .data();
      return userData;
    } catch (e) {
      if (userData.isEmpty) {
        throw RegistrationError(message: e.toString());
      } else {
        throw DatabaseError(message: e.toString());
      }
    }
  }

  @override
  Future<Map<String, dynamic>>? login(String email, String password,
      String enterpriseId, String collection) async {
    try {
      _authUser = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => value.user);
      final databaseUsersCollection = await _database
          .collection("enterprise")
          .doc(enterpriseId)
          .collection(collection)
          .get();
      userData = databaseUsersCollection.docs.firstWhere((element) {
        return element["${collection}Email"] == email &&
            element["${collection}Password"] == password &&
            element["businessPosition"] == collection;
      }).data();
      return userData;
    } catch (e) {
      if (userData.isEmpty) {
        throw AuthenticationError(message: e.toString());
      } else {
        throw OperatorNotFound(message: e.toString());
      }
    }
  }

  @override
  Future<Map<String, dynamic>>? getUserById(
      String? enterpriseId, String? operatorId, String? collection) async {
    try {
      final databaseCollection = await _database
          .collection("enterprise")
          .doc(enterpriseId)
          .collection(collection!)
          .get();
      userData = databaseCollection.docs
          .firstWhere((element) => element["${collection}Id"] == operatorId)
          .data();
      return userData;
    } catch (e) {
      throw OperatorNotFound(message: e.toString());
    }
  }
  
  @override
  Future<bool>? checkOperatorDataForResetPassword(String? email, String? operatorCode, String? enterpriseId, String? collection) {
    // TODO: implement checkOperatorDataForResetPassword
    throw UnimplementedError();
  }
  
  @override
  Future<void>? resetOperatorPassword(String? email, String? operatorCode, String? enterpriseId, String? newPassword) {
    // TODO: implement resetOperatorPassword
    throw UnimplementedError();
  }
  
  @override
  Future<void>? signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

}
