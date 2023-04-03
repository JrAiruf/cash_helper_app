import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/external/firebase_database.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/operator_module/infra/models/operator_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FirebaseDatabaseMock extends Mock implements FirebaseDatabase {}

class LoginRepositoryMock implements LoginRepository {
  LoginRepositoryMock({required ApplicationLoginDatabase datasource})
      : _datasource = datasource;
  final ApplicationLoginDatabase _datasource;

  bool _validOperatorEntries(OperatorModel? operatorModel, String? collection) {
    return operatorModel != null && collection != null && collection.isNotEmpty;
  }

  @override
  Future<OperatorModel?>? register(OperatorModel? newOperator, String? collection) async {
    if (_validOperatorEntries(newOperator, collection)) {
      await _datasource.register(newOperator?.toMap(), collection);
      final repositoryOperator = await _datasource.getOperatorById(newOperator?.operatorId, collection);
      return OperatorModel.fromMap(repositoryOperator ?? {});
    } else {
      return null;
    }
  }

  @override
  Future<OperatorModel?>? login(
      String? email, String? password, String? collection) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<OperatorModel?>? getOperatorById(
      String? operatorId, String? collection) {
    // TODO: implement getOperatorById
    throw UnimplementedError();
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
  Future<void>? signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
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
          when(datasource.register(any, any)).thenReturn(null);
          final result = await repository.register(newOperator, "collection");
          expect(result, isA<OperatorModel>());
          expect(result?.operatorId != null, equals(true));
        },
      );
      test(
        "Fail Converting data and creating operator",
        () async {
          when(datasource.register(any, any)).thenReturn(null);
          final result = await repository.register(newOperator, "");
          expect(result == null, equals(true));
        },
      );
    },
  );
}
