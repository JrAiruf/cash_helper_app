import 'package:cash_helper_app/app/modules/enterprise_module/external/data/application_enterprise_database.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/external/errors/enterprise_database_errors.dart';
import 'package:cash_helper_app/app/utils/enterprise_test_objects/test_objects.dart';
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

void main() {
  late MockUser user;
  late MockFirebaseAuth authMock;
  late FakeFirebaseFirestore firebaseMock;
  late Uuid uuid;
  late EnterpriseDatabaseMock database;
  setUp(() {
    user = MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'email@email.com',
      displayName: 'Junior',
    );
    authMock = MockFirebaseAuth(mockUser: user);
    firebaseMock = FakeFirebaseFirestore();
    uuid = const Uuid();
    database = EnterpriseDatabaseMock(
        database: firebaseMock, auth: authMock, uuid: uuid);
  });
  group(
    'CreateEnterpriseAccount Function should ...',
    () {
      test(
        'Create and Save an enterprise account in database',
        () async {
          await database
              .createEnterpriseAccount(EnterpriseTestObjects.enterpriseMap);
          final result = await firebaseMock.collection("enterprise").get();
          expect(result.docs.isNotEmpty, equals(true));
        },
      );
      test(
        'Fail to create enterprise account',
        () async {
          await database.createEnterpriseAccount({});
          final result = await firebaseMock.collection("enterprise").get();
          expect(result.docs.isEmpty, equals(true));
        },
      );
    },
  );
}
