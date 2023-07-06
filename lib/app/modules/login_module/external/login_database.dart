import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../../../services/crypt_serivce.dart';
import 'errors/authentication_error.dart';
import 'errors/database_error.dart';
import 'errors/operators_unavailable.dart';
import 'errors/user_not_found_error.dart';
import 'errors/registration_error.dart';

class FirebaseDatabase implements ApplicationLoginDatabase {
  FirebaseDatabase({
    required FirebaseFirestore database,
    required FirebaseAuth auth,
    required ICryptService encryptService,
    required Uuid uuid,
  })  : _database = database,
        _auth = auth,
        _encryptService = encryptService,
        _uuid = uuid;

  final FirebaseFirestore _database;
  final FirebaseAuth _auth;
  final ICryptService _encryptService;
  final Uuid _uuid;
  User? _authUser;
  Map<String, dynamic> userData = {};

  String userBusinessPosition = "";
  String _createUserCode(String source, int hashSize) {
    final index = source.length ~/ source.length;
    return source.substring(index, index + hashSize);
  }

  @override
  Future<Map<String, dynamic>>? register(Map<String, dynamic>? newUserMap, String? enterpriseId, String? collection) async {
    late String newUserId;
    final userCode = _createUserCode(_uuid.v1(), 6);
    try {
      _authUser = await _auth.createUserWithEmailAndPassword(email: newUserMap!['${collection}Email'], password: newUserMap['${collection}Password']).then((value) => value.user);
      newUserId = _authUser!.uid;
      newUserMap["${collection}Id"] = newUserId;
      newUserMap["${collection}Code"] = userCode;
      newUserMap['${collection}Password'] = _encryptService.generateHash(newUserMap['${collection}Password']);
      newUserMap.isNotEmpty && enterpriseId!.isNotEmpty && _authUser!.uid.isNotEmpty
          ? await _database.collection("enterprise").doc(enterpriseId).collection(newUserMap["businessPosition"]).doc(newUserId).set(newUserMap)
          : null;
      final registeredUsersList = await _database.collection("enterprise").doc(enterpriseId).collection(newUserMap["businessPosition"]).get();
      userData = registeredUsersList.docs.firstWhere((element) => element.data()["${collection}Id"] == newUserId).data();
      await Future.delayed(const Duration(seconds: 2));
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
  Future<Map<String, dynamic>>? login(String? email, String? password, String? enterpriseId, String? collection) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      _authUser = await _auth.signInWithEmailAndPassword(email: email ?? "", password: password ?? "").then((value) => value.user);
      final usersMapList = await _database.collection("enterprise").doc(enterpriseId).collection(collection!).get();
      userBusinessPosition = usersMapList.docs.isNotEmpty ? collection : "";
      final databaseUsersCollection = await _database.collection("enterprise").doc(enterpriseId).collection(userBusinessPosition).get();
      userData = databaseUsersCollection.docs.firstWhere((element) {
        final verifiedHashCode = _encryptService.checkHashCode(password!, element["${collection}Password"]);
        return element["${collection}Email"] == email && verifiedHashCode;
      }).data();
      return userData;
    } on FirebaseException catch (e) {
      if (e.code == "wrong-password" || e.code == "user-not-found") {
        throw AuthenticationError(message: e.message!);
      } else {
        throw UserNotFound(message: e.message!);
      }
    } catch (e) {
      throw UserNotFound(message: e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>>? getUserById(String? enterpriseId, String? operatorId, String? collection) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final databaseCollection = await _database.collection("enterprise").doc(enterpriseId).collection(collection!).get();
      userData = databaseCollection.docs.firstWhere((element) => element["${collection}Id"] == operatorId).data();
      return userData;
    } catch (e) {
      throw UserNotFound(message: e.toString());
    }
  }

  @override
  Future<bool>? checkOperatorDataForResetPassword(String? email, String? operatorCode, String? enterpriseId, String? collection) {
    throw UnimplementedError();
  }

  @override
  Future<void>? resetOperatorPassword(String? email, String? operatorCode, String? enterpriseId, String? newPassword) {
    throw UnimplementedError();
  }

  @override
  Future<void>? signOut() async {
    await _auth.signOut();
    userData.clear();
  }
  
  @override
  Future<List<Map<String, dynamic>>>? getAllOperators(String enterpriseId) async {
    try {
      final operatorsCollection = await _database.collection("enterprise").doc(enterpriseId).collection("operator").get();
      final operatorsList = operatorsCollection.docs.map((operatorDocument) => operatorDocument.data()).toList();
      if (operatorsList.isNotEmpty) {
        return operatorsList;
      } else {
        throw OperatorsUnavailable(message: "Nenhum Usuário encontrado");
      }
    } catch (e) {
        throw OperatorsUnavailable(message: e.toString());
    }
  }
}
