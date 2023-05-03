import 'package:cash_helper_app/app/modules/user_module/external/data/operator_database.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/data/operator_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../login_module/infra/repository/login_repository_impl_test.dart';

class OperatorDatabaseMock extends Mock implements OperatorDatabase {}
/* 
class OperatorRepositoryMock implements OperatorRepository {
  OperatorRepositoryMock({required OperatorDatabase database})
      : _database = database;

  final OperatorDatabase _database;

  @override
  Future<void> changeOperatorEmail(String? newEmail, String? operatorCode,
      String? operatorPassword, String? collection) async {
    if (_validOperatorData(newEmail, operatorCode, operatorPassword)) {
      return await _database.changeUserEmail(
          newEmail, operatorCode, operatorPassword, collection);
    } else {
      return;
    }
  }

  @override
  Future<void> deleteOperatorAccount(String? operatorCode, String? newEmail,
      String? operatorPassword, String? collection) async {
    if (_validOperatorData(newEmail, operatorCode, operatorPassword)) {
      return await _database.deleteUserAccount(
          operatorCode, newEmail, operatorPassword, collection);
    } else {
      return;
    }
  }

  @override
  Future? changeOperatorPassword(String? newPassword, String? operatorCode,
      String? currentPassword, String? collection) async {
    if (_validOperatorData(newPassword, operatorCode, currentPassword)) {
      return await _database.changeUserPassword(
          newPassword, operatorCode, currentPassword, collection);
    } else {
      return;
    }
  }

  @override
  Future<void> openOperatorCash(
      String? operatorId, String? collection, String? oppeningTime) async {
    if (_validOperatorData(operatorId, collection, oppeningTime)) {
      await _database.openOperatorCash(operatorId, collection, oppeningTime);
    } else {
      return;
    }
  }

  @override
  Future<void> closeOperatorCash(
      String? operatorId, String? collection) async {}

  bool _validOperatorData(
          String? newEmail, String? operatorCode, String? operatorPassword) =>
      newEmail!.isNotEmpty &&
      operatorCode!.isNotEmpty &&
      operatorPassword!.isNotEmpty;
}

void main() {
  final loginDatabase = FirebaseDatabaseMock();
  final loginRepository = LoginRepositoryMock(datasource: loginDatabase);
  final operatorDatabase = OperatorDatabaseMock();
  final operatorRepository = OperatorRepositoryMock(database: operatorDatabase);
  final newOperator = OperatorModel(
    operatorId: 'q34u6hu1qeuyoio',
    operatorNumber: 1,
    operatorName: 'Josy Kelly',
    operatorEmail: 'josy@email.com',
    operatorPassword: '12345678',
    operatorOppening: 'operatorOppening',
    operatorClosing: 'operatorClosing',
    operatorEnabled: false,
    operatorOcupation: "operator",
  );

  group(
    "changeUserEmail Function should",
    () {
      test(
        "Call database function to change operator's email",
        () async {
          when(loginDatabase.register(any, any))
              .thenAnswer((_) async => databaseOperator);
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => modifiedDatabaseOperator);
          final createdOperator = await loginRepository.register(
              newOperator, newOperator.operatorOcupation);
          expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorDatabase.changeUserEmail(any, any, any, any))
              .thenReturn(null);
          await operatorRepository.changeOperatorEmail(
              "josy_kelly@email.com",
              createdOperator?.operatorCode,
              createdOperator?.operatorPassword,
              null);
          final currenteOperator =
              await loginRepository.getOperatorById("operatorId", "collection");
          expect(
              currenteOperator?.operatorEmail, equals("josy_kelly@email.com"));
        },
      );
      test(
        "Fail in change operator's e-mail",
        () async {
          when(loginDatabase.register(any, any))
              .thenAnswer((_) async => databaseOperator);
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => databaseOperator);
          final createdOperator = await loginRepository.register(
              newOperator, newOperator.operatorOcupation);
          expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorDatabase.changeUserEmail(any, any, any, any))
              .thenReturn(null);
          await operatorRepository.changeOperatorEmail("josy_kelly@email.com",
              "", createdOperator?.operatorPassword, "");
          final currenteOperator =
              await loginRepository.getOperatorById("operatorId", "collection");
          expect(currenteOperator?.operatorEmail, equals("josy@email.com"));
        },
      );
    },
  );
  group(
    "DeleteOperatorAccount Function should",
    () {
      test(
        "Call database function to delte operator's account",
        () async {
          when(loginDatabase.register(any, any))
              .thenAnswer((_) async => databaseOperator);
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => databaseOperator);
          final createdOperator = await loginRepository.register(
              newOperator, newOperator.operatorOcupation);
          expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorDatabase.deleteUserAccount(any, any, any, any))
              .thenReturn(null);
          await operatorRepository.deleteOperatorAccount(
              createdOperator?.operatorCode,
              createdOperator?.operatorEmail,
              createdOperator?.operatorPassword,
              createdOperator?.operatorOcupation);
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => null);
          final currenteOperator =
              await loginRepository.getOperatorById("operatorId", "collection");
          expect(currenteOperator?.operatorId, equals(null));
        },
      );
      test(
        "Fail to delete account",
        () async {
          when(loginDatabase.register(any, any))
              .thenAnswer((_) async => databaseOperator);
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => databaseOperator);
          final createdOperator = await loginRepository.register(
              newOperator, newOperator.operatorOcupation);
          expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorDatabase.deleteUserAccount(any, any, any, any))
              .thenReturn(null);
          await operatorRepository.deleteOperatorAccount(
              createdOperator?.operatorCode,
              "",
              createdOperator?.operatorPassword,
              "");
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => databaseOperator);
          final currenteOperator =
              await loginRepository.getOperatorById("operatorId", "collection");
          expect(currenteOperator == null, equals(false));
        },
      );
    },
  );
  group(
    "ChangeOperatorPassword Function should",
    () {
      test(
        "Call database function to change operator's password",
        () async {
          when(loginDatabase.register(any, any))
              .thenAnswer((_) async => databaseOperator);
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => modifiedDatabaseOperator);
          final createdOperator = await loginRepository.register(
              newOperator, newOperator.operatorOcupation);
          expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorDatabase.changeUserPassword(any, any, any, any))
              .thenReturn(null);
          await operatorRepository.changeOperatorPassword(
              "newPassword",
              createdOperator?.operatorCode,
              createdOperator?.operatorPassword,
              createdOperator?.operatorOcupation);
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => modifiedDatabaseOperator);
          final currenteOperator =
              await loginRepository.getOperatorById("operatorId", "collection");
          expect(currenteOperator?.operatorPassword, equals("newPassword"));
        },
      );
      test(
        "Fail to change operator password",
        () async {
          when(loginDatabase.register(any, any))
              .thenAnswer((_) async => databaseOperator);
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => databaseOperator);
          final createdOperator = await loginRepository.register(
              newOperator, newOperator.operatorOcupation);
          expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorDatabase.changeUserPassword(any, any, any, any))
              .thenReturn(null);
          await operatorRepository.changeOperatorPassword(
              "newPassword",
              createdOperator?.operatorCode,
              createdOperator?.operatorPassword,
              createdOperator?.operatorOcupation);
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => databaseOperator);
          final currenteOperator =
              await loginRepository.getOperatorById("operatorId", "collection");
          expect(currenteOperator?.operatorPassword, equals("12345678"));
        },
      );
    },
  );
  group(
    "OpenOperatorCash Function should",
    () {
      test(
        "Call database function to change operator's enabled stated (from false to true)",
        () async {
          when(loginDatabase.register(any, any))
              .thenAnswer((_) async => databaseOperator);
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => modifiedDatabaseOperator);
          final createdOperator = await loginRepository.register(
              newOperator, newOperator.operatorOcupation);
          expect(createdOperator != null, equals(true));
          when(operatorDatabase.openOperatorCash(any, any, any))
              .thenReturn(null);
          await operatorRepository.openOperatorCash(
            createdOperator?.operatorId,
            createdOperator?.operatorOcupation,
            "cashOppened",
          );
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => modifiedDatabaseOperator);
          final currenteOperator =
              await loginRepository.getOperatorById("operatorId", "collection");
          expect(
              currenteOperator?.operatorOppening, equals("cashOppened"));
        },
      );
      test(
        "Fail to change operator enabled state",
        () async {
          when(loginDatabase.register(any, any))
              .thenAnswer((_) async => databaseOperator);
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => modifiedDatabaseOperator);
          final createdOperator = await loginRepository.register(
              newOperator, newOperator.operatorOcupation);
          expect(createdOperator != null, equals(true));
          when(operatorDatabase.openOperatorCash(any, any, any))
              .thenReturn(null);
          await operatorRepository.openOperatorCash(
            "",
            createdOperator?.operatorOcupation,
            "cashOppened",
          );
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => modifiedDatabaseOperator);
          final currenteOperator =
              await loginRepository.getOperatorById("operatorId", "collection");
          expect(
              currenteOperator?.operatorOppening, equals("cashOppened"));
        },
      );
    },
  );
  group(
    "CloseOperatorCash Function should",
    () {
      test(
        "Call database function to change operator's enabled state (from true to false)",
        () async {
          when(loginDatabase.register(any, any))
              .thenAnswer((_) async => databaseOperator);
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => modifiedDatabaseOperator);
          final createdOperator = await loginRepository.register(
              newOperator, newOperator.operatorOcupation);
          expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorDatabase.changeUserPassword(any, any, any, any))
              .thenReturn(null);
          await operatorRepository.changeOperatorPassword(
              "newPassword",
              createdOperator?.operatorCode,
              createdOperator?.operatorPassword,
              createdOperator?.operatorOcupation);
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => modifiedDatabaseOperator);
          final currenteOperator =
              await loginRepository.getOperatorById("operatorId", "collection");
          expect(currenteOperator?.operatorPassword, equals("newPassword"));
        },
      );
      test(
        "Fail to change operator enabled state",
        () async {
          when(loginDatabase.register(any, any))
              .thenAnswer((_) async => databaseOperator);
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => databaseOperator);
          final createdOperator = await loginRepository.register(
              newOperator, newOperator.operatorOcupation);
          expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorDatabase.changeUserPassword(any, any, any, any))
              .thenReturn(null);
          await operatorRepository.changeOperatorPassword(
              "newPassword",
              createdOperator?.operatorCode,
              createdOperator?.operatorPassword,
              createdOperator?.operatorOcupation);
          when(loginDatabase.getOperatorById(any, any))
              .thenAnswer((_) async => databaseOperator);
          final currenteOperator =
              await loginRepository.getOperatorById("operatorId", "collection");
          expect(currenteOperator?.operatorPassword, equals("12345678"));
        },
      );
    },
  );
}

final databaseOperator = <String, dynamic>{
  'operatorId': 'q34u6hu1qeuyoio',
  'operatorNumber': 1,
  'operatorName': 'Josy Kelly',
  'operatorEmail': 'josy@email.com',
  'operatorPassword': '12345678',
  'operatorCode': '123456',
  'operatorOppening': 'operatorOppening',
  'operatorClosing': 'operatorClosing',
  'operatorEnabled': false,
  'operatorOcupation': "operator",
};
final modifiedDatabaseOperator = <String, dynamic>{
  'operatorId': 'q34u6hu1qeuyoio',
  'operatorNumber': 1,
  'operatorName': 'Josy Kelly',
  'operatorEmail': 'josy_kelly@email.com',
  'operatorPassword': 'newPassword',
  'operatorCode': 'newPas',
  'operatorOppening': 'cashOppened',
  'operatorClosing': 'operatorClosing',
  'operatorEnabled': false,
  'operatorOcupation': "operator",
};
 */