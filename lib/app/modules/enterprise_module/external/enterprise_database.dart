import 'package:cash_helper_app/app/modules/enterprise_module/external/data/application_enterprise_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import 'errors/enterprise_database_errors.dart';

class EnterpriseDatabase implements ApplicationEnterpriseDatabase {
EnterpriseDatabase({
    required FirebaseFirestore database,
    required FirebaseAuth auth,
    required Uuid uuid,
  })  : _database = database,
        _auth = auth,
        _uuid = uuid;

  final FirebaseFirestore _database;
  final FirebaseAuth _auth;
  final Uuid _uuid;

  @override
  Future<void> createEnterpriseAccount(
      Map<String, dynamic> enterpriseMap) async {
    if (enterpriseMap.isNotEmpty) {
      try {
        final enterpriseCredentials = await _auth
            .createUserWithEmailAndPassword(
                email: enterpriseMap['enterpriseEmail'],
                password: enterpriseMap['enterprisePassword'])
            .catchError((e) {
          throw CreateAccountError(message: e.toString());
        });
        enterpriseMap["enterpriseId"] = enterpriseCredentials.user?.uid;
        final operatorCodeResource = _uuid.v1();
        final enterpriseCode = _createEnterpriseCode(operatorCodeResource, 8);
        enterpriseMap["enterpriseCode"] = enterpriseCode;
        await _database
            .collection("enterprise")
            .doc(enterpriseMap["enterpriseId"])
            .set(enterpriseMap);
      } on FirebaseAuthException catch (e) {
        throw CreateAccountError(message: e.message!);
      } on FirebaseException catch (e) {
        throw CreateAccountError(message: e.message!);
      }
    } else {
      return;
    }
  }

  String _createEnterpriseCode(String source, int hashSize) {
    final index = source.length ~/ source.length - 1;
    return source.substring(index, index + hashSize);
  } 
}