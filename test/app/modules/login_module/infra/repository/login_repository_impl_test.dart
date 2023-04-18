import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/external/login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
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
      String? email, String? operatorCode, String? collection) async {
        if(email!.isNotEmpty && collection!.isNotEmpty){
          final checkedInformation = await _datasource.checkOperatorDataForResetPassword(email, operatorCode, collection) ?? false;
    return checkedInformation ? true : false;
        } else {
        return false;
        }
  }

  @override
  Future<void>? resetOperatorPassword(String? email,String? operatorCode, String? newPassword) async {
    if(email!.isNotEmpty && !operatorCode!.isNotEmpty && newPassword!.isNotEmpty){
     return await _datasource.resetOperatorPassword(email, operatorCode, newPassword);
    } else {
      return;
    }
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
    operatorCode: '123456',
    operatorOppening: 'operatorOppening',
    operatorClosing: 'operatorClosing',
    operatorEnabled: false,
    operatorOcupation:"operator",
  );
  final modifiedOperator = OperatorModel(
    operatorId: 'q34u6hu1qeuyoio',
    operatorNumber: 14,
    operatorName: ' Josy Kelly',
    operatorEmail: 'josy@email.com',
    operatorPassword: 'newPassword',
    operatorCode: 'newPas',
    operatorOppening: 'operatorOppening',
    operatorClosing: 'operatorClosing',
    operatorEnabled: true,
    operatorOcupation: "admin",
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
  group(
    "CheckOperatorDataForResetPassword function should",
    () {
      test(
        "Call database function to check operator informations",
        () async {
          when(datasource.register(any, any)).thenAnswer((_) async => databaseOperator);
          when(datasource.getOperatorById(any, any)).thenAnswer((_) async => databaseOperator);
          when(datasource.checkOperatorDataForResetPassword(any, any, any)).thenAnswer((_) async => true);

          final createdOperator = await repository.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorModel>());
          expect(createdOperator?.operatorId != null, equals(true));
          final checkedOperator = await repository.checkOperatorDataForResetPassword(createdOperator?.operatorEmail,createdOperator?.operatorCode,"collection");
          
          expect(checkedOperator, equals(true));
        },
      );
      test(
        "Return false, for non checked informations",
        () async {
             when(datasource.register(any, any)).thenAnswer((_) async => databaseOperator);
          when(datasource.getOperatorById(any, any)).thenAnswer((_) async => databaseOperator);
          when(datasource.checkOperatorDataForResetPassword(any, any, any)).thenAnswer((_) async => false);

          final createdOperator = await repository.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorModel>());
          expect(createdOperator?.operatorId != null, equals(true));
          final checkedOperator = await repository.checkOperatorDataForResetPassword("",createdOperator?.operatorCode,"");
          
          expect(checkedOperator, equals(false));
        },
      );
    },
  );
  group(
    "ResetOperatorPassword function should",
    () {
      test(
        "Call database to reset operator's login password",
        () async {
          when(datasource.register(any, any)).thenAnswer((_) async => databaseOperator);
          when(datasource.getOperatorById(any, any)).thenAnswer((_) async => databaseOperator);
          final createdOperator = await repository.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorModel>());
          expect(createdOperator?.operatorId != null, equals(true));
           when(datasource.getOperatorById(any, any)).thenAnswer((_) async => modifiedDatabaseOperator);
           await repository.resetOperatorPassword(createdOperator?.operatorEmail, createdOperator?.operatorCode, "newPassword");
          final currenteOpertor = await repository.getOperatorById(createdOperator?.operatorId, "collection");
          expect(currenteOpertor, isA<OperatorModel>());
          expect(currenteOpertor?.operatorPassword, equals("newPassword"));
        },
      );
      test(
        "Fail Reseting operator's login password",
        () async {
          when(datasource.register(any, any)).thenAnswer((_) async => databaseOperator);
          when(datasource.getOperatorById(any, any)).thenAnswer((_) async => databaseOperator);
          final createdOperator = await repository.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorModel>());
          expect(createdOperator?.operatorId != null, equals(true));
           when(datasource.getOperatorById(any, any)).thenAnswer((_) async => databaseOperator);
           await repository.resetOperatorPassword(createdOperator?.operatorEmail, createdOperator?.operatorCode, "newPassword");
          final currenteOpertor = await repository.getOperatorById(createdOperator?.operatorId, "collection");
          expect(currenteOpertor, isA<OperatorModel>());
          expect(currenteOpertor?.operatorPassword, equals("12345678"));
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


final databaseOperator = <String,dynamic>{
    'operatorId': 'q34u6hu1qeuyoio',
    'operatorNumber': 1,
    'operatorName': ' Josy Kelly',
    'operatorEmail': 'josy@email.com',
    'operatorPassword': '12345678',
    'operatorCode': '123456',
    'operatorOppening': 'operatorOppening',
    'operatorClosing': 'operatorClosing',
    'operatorEnabled': false,
    'operatorOcupation': "operator",
  };
final modifiedDatabaseOperator = <String,dynamic>{
    'operatorId': 'q34u6hu1qeuyoio',
    'operatorNumber': 1,
    'operatorName': ' Josy Kelly',
    'operatorEmail': 'josy@email.com',
    'operatorPassword': 'newPassword',
    'operatorCode': 'newPas',
    'operatorOppening': 'operatorOppening',
    'operatorClosing': 'operatorClosing',
    'operatorEnabled': false,
    'operatorOcupation': "operator",
  };