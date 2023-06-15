// ignore_for_file: unused_import

import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/external/data/operator_database.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/data/operator_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../mocks/mocks.dart';
import '../../../login_module/infra/repository/login_repository_impl_test.dart';

class OperatorDatabaseMock extends Mock implements OperatorDatabase {}

class OperatorRepoMock implements OperatorRepository {
  OperatorRepoMock({required OperatorDatabase database}) : _database = database;

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
      String? operatorId, String? collection, String? closingTime) async {
    if (_validOperatorData(operatorId, collection, closingTime)) {
      await _database.closeOperatorCash(operatorId, collection, closingTime);
    } else {
      return;
    }
  }

  bool _validOperatorData(
          String? newEmail, String? operatorCode, String? operatorPassword) =>
      newEmail!.isNotEmpty &&
      operatorCode!.isNotEmpty &&
      operatorPassword!.isNotEmpty;
}

void main() {
  late FirebaseDatabaseMock loginDatabase;
  late LoginRepoMock loginRepository;
  late OperatorDatabaseMock operatorDatabase;
  late OperatorRepoMock operatorRepository;
  setUp(
    () {
      loginDatabase = FirebaseDatabaseMock();
      operatorDatabase = OperatorDatabaseMock();
      loginRepository = LoginRepoMock(
          datasource: loginDatabase, dataVerifier: DataVerifier());
      operatorRepository = OperatorRepoMock(database: operatorDatabase);
    },
  );
  group(
    "OpenOperatorCash Function Should",
    () {
      test(
        "Call datasource to open operator cash",
        () async {
          when(loginDatabase.getUserById(any, any, any))
              .thenAnswer((_) async => LoginTestObjects.modifiedUser);
          when(operatorDatabase.openOperatorCash(any, any, any))
              .thenReturn(null);
          await operatorRepository.openOperatorCash(
              "operatorId", "collection", "oppeningTime");
          final currentOperator = await loginRepository.getUserById(
              "enterpriseId", "operatorId", "collection") as OperatorModel;
          expect(currentOperator.operatorEnabled, equals(true));
        },
      );
      test(
        "Fail to open operator cash",
        () async {
          when(loginDatabase.getUserById(any, any, any))
              .thenAnswer((_) async => LoginTestObjects.newRepositoryOperator);
          when(operatorDatabase.openOperatorCash(any, any, any))
              .thenReturn(null);
          await operatorRepository.openOperatorCash(
              "operatorId", "collection", "closingTime");
          final currentOperator = await loginRepository.getUserById(
              "enterpriseId", "", "collection") as OperatorModel;
          expect(currentOperator.operatorEnabled, equals(false));
        },
      );
    },
  );
  group(
    "CloseOperatorCash Function Should",
    () {
      test(
        "Call datasource to close operator cash",
        () async {
          when(loginDatabase.getUserById(any, any, any))
              .thenAnswer((_) async => LoginTestObjects.newRepositoryOperator);
          when(operatorDatabase.closeOperatorCash(any, any, any))
              .thenReturn(null);
          await operatorRepository.closeOperatorCash(
              "operatorId", "collection", "oppeningTime");
          final currentOperator = await loginRepository.getUserById(
              "enterpriseId", "operatorId", "collection") as OperatorModel;
          expect(currentOperator.operatorEnabled, equals(false));
        },
      );
    },
  );
}
