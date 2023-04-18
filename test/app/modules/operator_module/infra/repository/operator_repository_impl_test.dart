import 'package:cash_helper_app/app/modules/operator_module/external/data/operator_database.dart';
import 'package:cash_helper_app/app/modules/operator_module/infra/data/operator_repository.dart';
import 'package:cash_helper_app/app/modules/operator_module/infra/models/operator_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../login_module/infra/repository/login_repository_impl_test.dart';

class OperatorDatabaseMock extends Mock implements OperatorDatabase {}

class OperatorRepositoryMock implements OperatorRepository {
  OperatorRepositoryMock({required OperatorDatabase database})
      : _database = database;

  final OperatorDatabase _database;

  @override
  Future<void> changeOperatorEmail(
      String? newEmail, String? operatorCode, String? operatorPassword,String? collection) async {
        if (_validOperatorData(newEmail, operatorCode, operatorPassword)) {
    return await _database.changeOperatorEmail(newEmail, operatorCode, operatorPassword, collection);
        } else {
          return;
        }
  }

  @override
  Future<void> deleteOperatorAccount(
      String? operatorCode, String? newEmail, String? operatorPassword,String? collection) async {
        if (_validOperatorData(newEmail, operatorCode, operatorPassword)) {
     return await _database.deleteOperatorAccount(operatorCode, newEmail, operatorPassword, collection);
        } else {
          return;
        }
  }

  bool _validOperatorData(
          String? newEmail, String? operatorCode, String? operatorPassword) =>
      newEmail!.isNotEmpty && operatorCode!.isNotEmpty && operatorPassword!.isNotEmpty;
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
  final modifiedOperator = OperatorModel(
    operatorId: 'q34u6hu1qeuyoio',
    operatorNumber: 14,
    operatorName: 'Josy Kelly',
    operatorEmail: 'josy@email.com',
    operatorPassword: 'newPassword',
    operatorOppening: 'operatorOppening',
    operatorClosing: 'operatorClosing',
    operatorEnabled: true,
    operatorOcupation: "admin",
  );
  group(
    "ChangeOperatorEmail Function should",
    () {
      test(
        "Call database function to change operator's email",
        () async {
          when(loginDatabase.register(any, any)).thenAnswer((_) async => databaseOperator);
          when(loginDatabase.getOperatorById(any, any)).thenAnswer((_) async => modifiedDatabaseOperator);
          final createdOperator = await loginRepository.register(
              newOperator, newOperator.operatorOcupation);
              expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorDatabase.changeOperatorEmail(any, any, any, any)).thenReturn(null);
          await operatorRepository.changeOperatorEmail("josy_kelly@email.com", createdOperator?.operatorCode, createdOperator?.operatorPassword,null);
        final currenteOperator = await loginRepository.getOperatorById("operatorId", "collection");
        expect(currenteOperator?.operatorEmail, equals("josy_kelly@email.com"));
        },
      );
      test(
        "Fail in change operator's e-mail",
        () async {
           when(loginDatabase.register(any, any)).thenAnswer((_) async => databaseOperator);
          when(loginDatabase.getOperatorById(any, any)).thenAnswer((_) async => databaseOperator);
          final createdOperator = await loginRepository.register(
              newOperator, newOperator.operatorOcupation);
              expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorDatabase.changeOperatorEmail(any, any, any, any)).thenReturn(null);
          await operatorRepository.changeOperatorEmail("josy_kelly@email.com", "", createdOperator?.operatorPassword,"");
        final currenteOperator = await loginRepository.getOperatorById("operatorId", "collection");
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
           when(loginDatabase.register(any, any)).thenAnswer((_) async => databaseOperator);
          when(loginDatabase.getOperatorById(any, any)).thenAnswer((_) async => databaseOperator);
          final createdOperator = await loginRepository.register(
              newOperator, newOperator.operatorOcupation);
              expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorDatabase.deleteOperatorAccount(any, any, any, any)).thenReturn(null);
          await operatorRepository.deleteOperatorAccount(createdOperator?.operatorCode,createdOperator?.operatorEmail
          , createdOperator?.operatorPassword, createdOperator?.operatorOcupation);
           when(loginDatabase.getOperatorById(any, any)).thenAnswer((_) async => null);
             final currenteOperator = await loginRepository.getOperatorById("operatorId", "collection");
             expect(currenteOperator?.operatorId, equals(null));

        },
      );
      test(
        "Fail to delete account",
        () async {
          when(loginDatabase.register(any, any)).thenAnswer((_) async => databaseOperator);
          when(loginDatabase.getOperatorById(any, any)).thenAnswer((_) async => databaseOperator);
          final createdOperator = await loginRepository.register(
              newOperator, newOperator.operatorOcupation);
              expect(createdOperator != null, equals(true));
          expect(createdOperator?.operatorName, equals("Josy Kelly"));
          when(operatorDatabase.deleteOperatorAccount(any, any, any, any)).thenReturn(null);
          await operatorRepository.deleteOperatorAccount(createdOperator?.operatorCode,""
          , createdOperator?.operatorPassword, "");
           when(loginDatabase.getOperatorById(any, any)).thenAnswer((_) async => databaseOperator);
             final currenteOperator = await loginRepository.getOperatorById("operatorId", "collection");
             expect(currenteOperator == null, equals(false));
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
  'operatorOppening': 'operatorOppening',
  'operatorClosing': 'operatorClosing',
  'operatorEnabled': false,
  'operatorOcupation': "operator",
};
