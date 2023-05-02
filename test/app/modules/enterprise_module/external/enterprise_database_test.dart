import 'package:cash_helper_app/app/modules/enterprise_module/external/data/application_enterprise_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

class EnterpriseDatabaseMock implements ApplicationEnterpriseDatabase {
  EnterpriseDatabaseMock({
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
  Future<Map<String, dynamic>> createEnterpriseAccount(
      Map<String, dynamic>? enterpriseMap) {
    // TODO: implement createEnterpriseAccount
    throw UnimplementedError();
  }

  Future<void>_sendEnterpriseCodeToEnterpriseEmail(
      {required String enterpriseCode,
      required String enterpriseEmail}) async {
        
      }
}

void main() {
  final user = MockUser(
    isAnonymous: false,
    uid: 'someuid',
    email: 'email@email.com',
    displayName: 'Junior',
  );
  final authMock = MockFirebaseAuth(mockUser: user);
  final firebaseMock = FakeFirebaseFirestore();
  const uuid = Uuid();
  final database = EnterpriseDatabaseMock(
      database: firebaseMock, auth: authMock, uuid: uuid);
  test('enterprise database ...', () async {
    // TODO: Implement test
  });
}
