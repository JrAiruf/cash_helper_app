import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/manager_model.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/mocks.dart';

class LoginRepositoryMock implements LoginRepository {
  LoginRepositoryMock({
    required ApplicationLoginDatabase datasource,
    required DataVerifier dataVerifier,
  })  : _datasource = datasource,
        _dataVerifier = dataVerifier;
  final ApplicationLoginDatabase _datasource;
  final DataVerifier _dataVerifier;

  @override
  Future<dynamic>? register(
      dynamic newUser, String? enterpriseId, String? collection) async {
    if (_dataVerifier.objectVerifier(object: newUser?.toMap() ?? {}) &&
        _dataVerifier.validateInputData(inputs: [enterpriseId, collection])) {
      if (_dataVerifier.operatorModelVerifier(model: newUser)) {
        final opertatorMap = await _datasource.register(
            newUser.toMap(), enterpriseId!, collection!);
        return OperatorModel.fromMap(opertatorMap);
      } else if (_dataVerifier.managerModelVerifier(model: newUser)) {
        final managerMap = await _datasource.register(
            newUser.toMap(), enterpriseId!, collection!);
        return ManagerModel.fromMap(managerMap);
      }
    } else {
      return null;
    }
  }

  @override
  Future<dynamic>? login(String? email, String? password, String? enterpriseId,
      String? collection) async {
    if (_dataVerifier.validateInputData(
        inputs: [email, password, enterpriseId, collection])) {
      final databaseMap =
          await _datasource.login(email!, password!, enterpriseId!, collection!);
      if (_dataVerifier.operatorMapVerifier(map: databaseMap)) {
        return OperatorModel.fromMap(databaseMap);
      } else if (_dataVerifier.managerMapVerifier(map: databaseMap)) {
        return ManagerModel.fromMap(databaseMap);
      }
    } else {
      return null;
    }
  }

  @override
  Future<dynamic>? getUserById(
      String? enterpriseId, String? operatorId, String? collection) async {
    if (_dataVerifier
        .validateInputData(inputs: [enterpriseId, operatorId, collection])) {
       final databaseMap = await _datasource.getUserById(enterpriseId, operatorId, collection);
       if (_dataVerifier.operatorMapVerifier(map: databaseMap ?? {})) {
           return OperatorModel.fromMap(databaseMap);
       } else if (_dataVerifier.managerMapVerifier(map: databaseMap ?? {})) {
        return ManagerModel.fromMap(databaseMap);
      }
    } else {
      return null;
    }
  }

  @override
  Future<bool>? checkOperatorDataForResetPassword(
      String? email, String? operatorCode, String? collection) {
    // TODO: implement checkOperatorDataForResetPassword
    throw UnimplementedError();
  }

  @override
  Future<void>? resetOperatorPassword(
      String? email, String? operatorCode, String? newPassword) {
    // TODO: implement resetOperatorPassword
    throw UnimplementedError();
  }

  @override
  Future<void>? signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}

void main() {
  late FirebaseDatabaseMock datasource;
  late LoginRepositoryMock repository;
  late DataVerifier dataVerifier;
  setUp(() {
    datasource = FirebaseDatabaseMock();
    dataVerifier = DataVerifier();
    repository =
        LoginRepositoryMock(datasource: datasource, dataVerifier: dataVerifier);
  });

  group(
    "Register function should",
    () {
      test(
        "Convert data coming from database and register a new operator",
        () async {
          when(datasource.register(any, any, any))
              .thenAnswer((_) async => LoginTestObjects.newOperator);
          final result = await repository.register(
              LoginTestObjects.newOperatorModel, 'enterpriseID', "collection");
          expect(result, isA<OperatorModel>());
          expect(result?.operatorId != null, equals(true));
        },
      );
      test(
        "Convert data coming from database and register a new manager",
        () async {
          when(datasource.register(any, any, any))
              .thenAnswer((_) async => LoginTestObjects.newManager);
          final result = await repository.register(
              LoginTestObjects.newManagerModel, 'enterpriseID', "collection");
          expect(result, isA<ManagerModel>());
          expect(result?.managerId != null, equals(true));
        },
      );
      test(
        "Fail Converting data and creating operator",
        () async {
          when(datasource.register(any, any, any)).thenReturn(null);
          final result = await repository.register(
              LoginTestObjects.newOperatorModel, null, null);
          expect(result == null, equals(true));
        },
      );
    },
  );
  group(
    "Login function should",
    () {
      test(
        "Convert data coming from database and authentitcate operator user successfully",
        () async {
          when(datasource.login(any, any, any, any))
              .thenAnswer((_) async => LoginTestObjects.newOperator);
          final loggedUser = await repository.login(
              "email", "password", "enterpriseId", "collection");
          expect(loggedUser, isA<OperatorModel>());
          expect(loggedUser?.operatorId != null, equals(true));
        },
      );
      test(
        "Convert data coming from database and authentitcate a manager successfully",
        () async {
          when(datasource.login(any, any, any, any))
              .thenAnswer((_) async => LoginTestObjects.newManager);
          final loggedUser = await repository.login(
              "email", "password", "enterpriseId", "collection");
          expect(loggedUser, isA<ManagerModel>());
          expect(loggedUser?.managerId != null, equals(true));
        },
      );
      test(
        "Fail Converting data and signing in",
        () async {
          when(datasource.login(any, any, any, any))
              .thenAnswer((_) async => {});
          final loginOperator =
              await repository.login("email", null, null, "collection");
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
          when(datasource.getUserById(any, any,any)).thenAnswer((_) async => LoginTestObjects.newOperator);
          final retrivedUser = await repository.getUserById("enterpriseId","operatorId", "collection");
          expect(retrivedUser, isA<OperatorModel>());
          expect(retrivedUser?.operatorId != null, equals(true));
        },
      );
      test(
        "Convert data coming from database and return an ManagerModel object",
        () async {
          when(datasource.getUserById(any, any,any)).thenAnswer((_) async => LoginTestObjects.newManager);
          final retrivedUser = await repository.getUserById("enterpriseId","managerId", "collection");
          expect(retrivedUser, isA<ManagerModel>());
          expect(retrivedUser?.managerId != null, equals(true));
        },
      );
      test(
        "Fail Converting data and returnining the object",
        () async {
          when(datasource.getUserById(any,any, any)).thenAnswer((_) async => null);
          final retriviedOperator = await repository.getUserById(null, "","collection");
          expect(retriviedOperator?.operatorId == null, equals(true));
        },
      );
    },
  );
  /*
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
*/
}
