import 'package:cash_helper_app/app/modules/enterprise_module/external/data/application_enterprise_database.dart';
import 'package:cash_helper_app/app/services/crypt_serivce.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import 'errors/enterprise_database_errors.dart';

class EnterpriseDatabase implements ApplicationEnterpriseDatabase {
  EnterpriseDatabase({
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
  Map<String, dynamic> enterpriseData = {};
  @override
  Future<Map<String, dynamic>>? createEnterpriseAccount(
      Map<String, dynamic>? enterpriseMap) async {
    try {
      final enterpriseCredentials = await _auth
          .createUserWithEmailAndPassword(
              email: enterpriseMap!['enterpriseEmail'],
              password: enterpriseMap['enterprisePassword'])
          .catchError((e) {
        throw CreateAccountError(message: e.toString());
      });
      enterpriseMap["enterpriseId"] = enterpriseCredentials.user?.uid;
      final operatorCodeResource = _uuid.v1();
      final enterpriseCode = _createEnterpriseCode(operatorCodeResource, 8);
      enterpriseMap["enterpriseCode"] = enterpriseCode;
      enterpriseMap['enterprisePassword'] =
          _encryptService.generateHash(enterpriseMap['enterprisePassword']);
      await _database
          .collection("enterprise")
          .doc(enterpriseMap["enterpriseId"])
          .set(enterpriseMap);
      enterpriseData = await _database
          .collection("enterprise")
          .doc(enterpriseMap["enterpriseId"])
          .get()
          .then((value) => value.data() ?? {});
      return enterpriseMap;
    } catch (e) {
      throw CreateAccountError(message: e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>?> getEnterpriseByCode(
      String? enterpriseCode) async {
    try {
      final enterprisesDocumentsList =
          await _database.collection("enterprise").get();
      final mathcerEntepriseDocument = enterprisesDocumentsList.docs.firstWhere(
          (element) => element.data()["enterpriseCode"] == enterpriseCode);
      return mathcerEntepriseDocument.data().isNotEmpty
          ? mathcerEntepriseDocument.data()
          : null;
    } catch (e) {
      throw EnterpriseAccountNotFoundError(message: e.toString());
    }
  }

  String _createEnterpriseCode(String source, int hashSize) {
    final index = source.length ~/ source.length - 1;
    return source.substring(index, index + hashSize);
  }
}
