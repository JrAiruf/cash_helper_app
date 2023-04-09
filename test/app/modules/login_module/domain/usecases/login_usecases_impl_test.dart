import 'package:cash_helper_app/app/modules/login_module/domain/contract/login_usecases.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/repository/login_repository_impl.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/operator_module/infra/models/operator_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LoginRepositoryMock extends Mock implements LoginRepositoryImpl {}

class LoginUsecasesMock implements LoginUsecases {
  LoginUsecasesMock(LoginRepository repository) : _repository = repository;

  final LoginRepository _repository;
  @override
  Future<OperatorEntity?>? register(
      OperatorEntity? newOperator, String? collection) async {
    if (newOperator != null && collection != null) {
      final operatorModelData = OperatorModel.fromEntityData(newOperator);
      final operatorModel = await _repository.register(operatorModelData, collection);
      return OperatorModel.toEntityData(operatorModel ?? OperatorModel());
    } else {
      return null;
    }
  }

  @override
  Future<OperatorEntity?>? login(
      String? email, String? password, String? collection) async {
  if(email != null && password != null && collection != null) {
      final operatorModel = await _repository.login(email, password, collection);
      return OperatorModel.toEntityData(operatorModel ?? OperatorModel());
  } else {
    return null;
  }
}

  @override
  Future<OperatorEntity?>? getOperatorById(
      String? operatorId, String? collection) async {
    if (operatorId != null && collection != null) {
        final operatorModel = await _repository.getOperatorById(operatorId, collection);
        return OperatorModel.toEntityData(operatorModel ?? OperatorModel());
    } else {
      return null;
    }
  }

  @override
  Future<bool>? checkOperatorDataForResetPassword(
      String? email, int? cashierNumber, String? collection) async {
  return await _repository.checkOperatorDataForResetPassword(email, cashierNumber, collection) ?? false;
  }

  @override
  Future<void>? resetOperatorPassword(String? email, int? cashierNumber, String? newPassword) async {
   await _repository.resetOperatorPassword(email, cashierNumber, newPassword);
  }

  @override
  Future<void>? signOut() async {
  await _repository.signOut();
  }
}

void main() {
  final repository = LoginRepositoryMock();
  final usecases = LoginUsecasesMock(repository);
  final newOperator = OperatorEntity(
    operatorId: 'q34u6hu1qeuyoio',
    operatorNumber: 1,
    operatorName: ' Josy Kelly',
    operatorEmail: 'josy@email.com',
    operatorPassword: '12345678',
    operatorOppening: 'operatorOppening',
    operatorClosing: 'operatorClosing',
    operatorEnabled: false,
    operatorOcupation: "operator",
  );
  final modifiedOperator = OperatorEntity(
    operatorId: 'q34u6hu1qeuyoio',
    operatorNumber: 14,
    operatorName: ' Josy Kelly',
    operatorEmail: 'josy@email.com',
    operatorPassword: '12345678',
    operatorOppening: 'operatorOppening',
    operatorClosing: 'operatorClosing',
    operatorEnabled: true,
    operatorOcupation: "admin",
  );
  group(
    "Register function should",
    () {
      test(
        "Convert the object coming from repository, to register a new operator",
        () async {
          when(repository.register(any, any))
              .thenAnswer((_) async => repositoryOperator);
          when(repository.login(any, any, any))
              .thenAnswer((_) async => repositoryOperator);
          final createdOperator =await usecases.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
        },
      );
      test(
        "Fail to convert the object",
        () async {
          when(repository.register(any, any))
              .thenAnswer((_) async => repositoryOperator);
          final createdOperator =
              await usecases.register(null, "collection");
          expect(createdOperator, equals(null));
          expect(createdOperator?.operatorId == null, equals(true));
        },
      );
    },
  );
  group(
    "Login function should",
    () {
      test(
        "Call repository function to signIn",
        () async {
           when(repository.register(any, any)).thenAnswer((_) async => repositoryOperator);
          when(repository.login(any, any, any)).thenAnswer((_) async => repositoryOperator);
          final createdOperator = await usecases.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
          final loginOperator = await usecases.login(createdOperator?.operatorEmail, createdOperator?.operatorPassword, createdOperator?.operatorOcupation.toString());
          expect(loginOperator, isA<OperatorEntity>());
          expect(loginOperator?.operatorId != null, equals(true));
        },
      );
      test(
        "Fail to sign In",
        () async {
           when(repository.register(any, any)).thenAnswer((_) async => repositoryOperator);
          when(repository.login(any, any, any)).thenAnswer((_) async => null);
          final createdOperator = await usecases.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
          final loginOperator = await usecases.login(null, "", "");
          expect(loginOperator, equals(null));
        },
      );
    },
  );
  group(
    "GetOperatorById function should",
    () {
      test(
        "Call repository function to retrieve operator entity",
       () async {
          when(repository.register(any, any)).thenAnswer((_) async => repositoryOperator);
          when(repository.getOperatorById(any, any)).thenAnswer((_) async => repositoryOperator);
          final createdOperator = await usecases.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
          final retriviedOperator = await usecases.getOperatorById(createdOperator?.operatorEmail, "collection");
          expect(retriviedOperator, isA<OperatorEntity>());
          expect(retriviedOperator != null, equals(true));
          expect(retriviedOperator?.operatorId != null, equals(true));
        },
      );
      test(
        "Fail retrieving the entity",
        () async {
          when(repository.register(any, any)).thenAnswer((_) async => repositoryOperator);
          when(repository.getOperatorById(any, any)).thenAnswer((_) async => repositoryOperator);
          final createdOperator = await usecases.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
          final retriviedOperator = await usecases.getOperatorById(null, "collection");
          expect(retriviedOperator?.operatorId == null, equals(true));
        },
      );
    },
  );
  group(
    "CheckOperatorDataForResetPassword function should",
    () {
      test(
        "Call repository function to check opertor's informations",
       () async {
          when(repository.register(any, any)).thenAnswer((_) async => repositoryOperator);
          when(repository.checkOperatorDataForResetPassword(any, any,any)).thenAnswer((_) async => true);
          final createdOperator = await usecases.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
          final checkedInformation = await usecases.checkOperatorDataForResetPassword(createdOperator?.operatorEmail, createdOperator?.operatorNumber,"collection");
          expect(checkedInformation, equals(true));
          
        },
      );
      test(
        "Return false for non checked informations",
        () async {
        when(repository.register(any, any)).thenAnswer((_) async => repositoryOperator);
          when(repository.checkOperatorDataForResetPassword(any, any,any)).thenAnswer((_) async => false);
          final createdOperator = await usecases.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
          final checkedInformation = await usecases.checkOperatorDataForResetPassword(createdOperator?.operatorEmail, createdOperator?.operatorNumber,"");
          expect(checkedInformation, equals(false));
        },
      );
    },
  );
  group(
    "ResetOperatorPassword function should",
    () {
      test(
        "Call repository function to reset operator's password",
       () async {
          when(repository.register(any, any)).thenAnswer((_) async => repositoryOperator);
          when(repository.getOperatorById(any, any)).thenAnswer((_) async => modifiedRepositoryOperator);
          when(repository.resetOperatorPassword(any, any,any)).thenReturn(null);

          final createdOperator = await usecases.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
          await usecases.resetOperatorPassword(createdOperator?.operatorEmail, createdOperator?.operatorNumber, "newPassword");
          final currentOperator = await usecases.getOperatorById(createdOperator?.operatorEmail, "collection");

          expect(currentOperator?.operatorPassword, equals("newPassword"));
        },
      );
      test(
        "Fail reseting operator's password",
        () async {
             when(repository.register(any, any)).thenAnswer((_) async => repositoryOperator);
          when(repository.getOperatorById(any, any)).thenAnswer((_) async => repositoryOperator);
          when(repository.resetOperatorPassword(any, any,any)).thenReturn(null);
          
          final createdOperator = await usecases.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
          await usecases.resetOperatorPassword(createdOperator?.operatorEmail, createdOperator?.operatorNumber, "newPassword");
          final currentOperator = await usecases.getOperatorById(createdOperator?.operatorEmail, "collection");

          expect(currentOperator?.operatorPassword, equals("12345678"));
        },
      );
    },
  );
  test(
    "Should sign out the application",
    () async {
    when(repository.register(any, any)).thenAnswer((_) async => repositoryOperator);
          when(repository.login(any, any, any)).thenAnswer((_) async => repositoryOperator);
          when(repository.signOut()).thenReturn(null);
          when(repository.getOperatorById(any, any)).thenAnswer((_) async => null);
          final createdOperator = await usecases.register(newOperator, "collection");
          expect(createdOperator, isA<OperatorEntity>());
          expect(createdOperator?.operatorId != null, equals(true));
          final loginOperator = await usecases.login(createdOperator?.operatorEmail, createdOperator?.operatorPassword, createdOperator?.operatorOcupation.toString());
          expect(loginOperator, isA<OperatorEntity>());
          expect(loginOperator?.operatorId != null, equals(true));
          await usecases.signOut();
          final loggedOffOperator = await usecases.getOperatorById("id","collection");
          expect(loggedOffOperator?.operatorId, equals(null));
          
    },
  );
}

final repositoryOperator = OperatorModel(
  operatorId: 'q34u6hu1qeuyoio',
  operatorNumber: 1,
  operatorName: ' Josy Kelly',
  operatorEmail: 'josy@email.com',
  operatorPassword: '12345678',
  operatorOppening: 'operatorOppening',
  operatorClosing: 'operatorClosing',
  operatorEnabled: false,
  operatorOcupation: "operator",
);
final modifiedRepositoryOperator = OperatorModel(
  operatorId: 'q34u6hu1qeuyoio',
  operatorNumber: 1,
  operatorName: ' Josy Kelly',
  operatorEmail: 'josy@email.com',
  operatorPassword: 'newPassword',
  operatorOppening: 'operatorOppening',
  operatorClosing: 'operatorClosing',
  operatorEnabled: false,
  operatorOcupation: "operator",
);
