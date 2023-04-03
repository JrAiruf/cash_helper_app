import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/external/firebase_database.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/operator_module/infra/models/operator_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FirebaseDatabaseMock extends Mock implements FirebaseDatabase {}

class LoginRepositoryMock implements LoginRepository {
  LoginRepositoryMock({required ApplicationLoginDatabase datasource})
      : _datasource = datasource;
  final ApplicationLoginDatabase _datasource;

  

  @override
  Future<OperatorModel?>? register(OperatorModel? newOperator, String? collection) async {
    if (newOperator != null && collection !=null) {
      final databaseOperator = await _datasource.register(newOperator.toMap(), collection);
      return OperatorModel.fromMap(databaseOperator ?? {});
    } else {
      return null;
    }
  }

  @override
  Future<OperatorModel?>? login(
      String? email, String? password, String? collection) async {
   if (email != null && password !=null) {
      final databaseOperator = await _datasource.login(email, password, collection);
      return OperatorModel.fromMap(databaseOperator ?? {});
    } else {
      return null;
    }
  }

  @override
  Future<OperatorModel?>? getOperatorById(
      String? operatorId, String? collection) async {
if (operatorId != null && collection != null) {
  final databaseOperator = await _datasource.getOperatorById(operatorId, collection);
  return OperatorModel.fromMap(databaseOperator ?? {});
} else {
  return null;
}
  }

  @override
  Future<bool>? checkOperatorDataForResetPassword(
      String? email, int? cashierNumber, String? collection) {
    // TODO: implement checkOperatorDataForResetPassword
    throw UnimplementedError();
  }

  @override
  Future<void>? resetOperatorPassword(String? email, int? cashierNumber,
      String? collection, String? newPassword) {
    // TODO: implement resetOperatorPassword
    throw UnimplementedError();
  }

  @override
  Future<void>? signOut() async {
    await _datasource.signOut();
  }
}

void main() {

  final datasource = FirebaseDatabaseMock();
  final repository = LoginRepositoryMock(datasource: datasource);
  final newOperator = OperatorModel(
    operatorId: 'q34u6hu1qeuyoio',
    operatorNumber: 1,
    operatorName: ' Josy Kelly',
    operatorEmail: 'josy@email.com',
    operatorPassword: '12345678',
    operatorOppening: 'operatorOppening',
    operatorClosing: 'operatorClosing',
    operatorEnabled: false,
    operatorOcupation: OperatorOccupation.cashierOperator,
  );
  final modifiedOperator = OperatorModel(
    operatorId: 'q34u6hu1qeuyoio',
    operatorNumber: 14,
    operatorName: ' Josy Kelly',
    operatorEmail: 'josy@email.com',
    operatorPassword: '12345678',
    operatorOppening: 'operatorOppening',
    operatorClosing: 'operatorClosing',
    operatorEnabled: true,
    operatorOcupation: OperatorOccupation.admin,
  );
  group(
    "Register function should",
    () {
      test(
        "Convert data coming from database and register a new operator",
        () async {
          when(datasource.register(any, any)).thenAnswer((_) async => databaseOperator);
          final result = await repository.register(newOperator, "collection");
          expect(result, isA<OperatorModel>());
          expect(result?.operatorId != null, equals(true));
        },
      );
      test(
        "Fail Converting data and creating operator",
        () async {
          when(datasource.register(any, any)).thenReturn(null);
          final result = await repository.register(newOperator, null);
          expect(result == null, equals(true));
        },
      );
    },
  );
  group(
    "Login function should",
    () {
      test(
        "Convert data coming from database and signIn successfully",
        () async {
          when(datasource.register(any, any)).thenAnswer((_) async => databaseOperator);
          when(datasource.login(any, any, any)).thenAnswer((_) async => databaseOperator);
          final createdOperator = await repository.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorModel>());
          expect(createdOperator?.operatorId != null, equals(true));
          final loginOperator = await repository.login(createdOperator?.operatorEmail, createdOperator?.operatorPassword, createdOperator?.operatorOcupation.toString());
          expect(loginOperator, isA<OperatorModel>());
          expect(loginOperator?.operatorId != null, equals(true));
        },
      );
      test(
        "Fail Converting data and signing in",
        () async {
         when(datasource.register(any, any)).thenAnswer((_) async => databaseOperator);
          when(datasource.login(any, any, any)).thenAnswer((_) async => null);
          final createdOperator = await repository.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorModel>());
          expect(createdOperator?.operatorId != null, equals(true));
          final loginOperator = await repository.login(null, "", "");
          expect(loginOperator, equals(null));
        },
      );
    },
  );
  group(
    "GetOperatorById function should",
    () {
      test(
        "Convert data coming from database and return an OperatorModel object",
        () async {
          when(datasource.register(any, any)).thenAnswer((_) async => databaseOperator);
          when(datasource.getOperatorById(any, any)).thenAnswer((_) async => databaseOperator);
          final createdOperator = await repository.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorModel>());
          expect(createdOperator?.operatorId != null, equals(true));
          final retriviedOperator = await repository.getOperatorById(createdOperator?.operatorEmail, "collection");
          expect(retriviedOperator, isA<OperatorModel>());
          expect(retriviedOperator != null, equals(true));
          expect(retriviedOperator?.operatorId != null, equals(true));
        },
      );
      test(
        "Fail Converting data and returnining the object",
        () async {
          when(datasource.register(any, any)).thenAnswer((_) async => databaseOperator);
          when(datasource.getOperatorById(any, any)).thenAnswer((_) async => databaseOperator);
          final createdOperator = await repository.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorModel>());
          expect(createdOperator?.operatorId != null, equals(true));
          final retriviedOperator = await repository.getOperatorById(null, "collection");
          expect(retriviedOperator?.operatorId == null, equals(true));
        },
      );
    },
  );

      test(
        "Call database function to signOut the application",
        () async {
          when(datasource.register(any, any)).thenAnswer((_) async => databaseOperator);
          when(datasource.login(any,any, any)).thenAnswer((_) async => databaseOperator);
          when(datasource.signOut()).thenReturn(null);
          when(datasource.getOperatorById(any, any)).thenAnswer((_) async => null);
          final createdOperator = await repository.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorModel>());
          expect(createdOperator?.operatorId != null, equals(true));
          final retriviedOperator = await repository.login(createdOperator?.operatorEmail,createdOperator?.operatorPassword, "collection");
          expect(retriviedOperator, isA<OperatorModel>());
          expect(retriviedOperator != null, equals(true));
          expect(retriviedOperator?.operatorId != null, equals(true));
          await repository.signOut();
          final loggedOffOperator = await repository.getOperatorById("id", "collection");
          expect(loggedOffOperator?.operatorId == null, equals(true));
        },
      );
}


final databaseOperator = {
    'operatorId': 'q34u6hu1qeuyoio',
    'operatorNumber': 1,
    'operatorName': ' Josy Kelly',
    'operatorEmail': 'josy@email.com',
    'operatorPassword': '12345678',
    'operatorOppening': 'operatorOppening',
    'operatorClosing': 'operatorClosing',
    'operatorEnabled': false,
    'operatorOcupation': OperatorOccupation.cashierOperator,
  };