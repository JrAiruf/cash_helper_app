import 'package:cash_helper_app/app/modules/login_module/domain/contract/login_usecases.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/login_usecases_impl.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_states.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LoginUsecasesMock extends Mock implements LoginUsecasesImpl {}

class LoginStore extends ValueNotifier<LoginStates> {
  LoginStore({required this.usecases}) : super(LoginInitialState());
  final LoginUsecases usecases;

  Future<OperatorEntity?>? register(
      OperatorEntity newOperator, String collection) async {
    value = LoginLoadingState();
    final operatorEntity = await usecases.register(newOperator, collection);
    operatorEntity != null
        ? value = LoginSuccessState(operatorEntity: operatorEntity)
        : value = LoginErrorState(message: "Usuário não criado");
    return operatorEntity;
  }

  Future<OperatorEntity?>? login(
      String? email, String? password, String? collection) async {
    value = LoginLoadingState();
    final operatorEntity = await usecases.login(email, password, collection);
    operatorEntity != null
        ? value = LoginSuccessState(operatorEntity: operatorEntity)
        : value = LoginErrorState(message: "Usuário não encontrado");
    return operatorEntity;
  }
}

void main() {
  final usecases = LoginUsecasesMock();
  final store = LoginStore(usecases: usecases);
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
  group(
    "Register function should",
    () {
      test(
        "Create an operator, return an OperatorEntity object and change the value of LoginStore(to LoginSuccessState)",
        () async {
          when(usecases.register(any, any))
              .thenAnswer((_) async => usecasesOperator);
          final createdOperator =
              await store.register(newOperator, "collection");
          final storeValue = store.value;
          expect(createdOperator != null, equals(true));
          expect(storeValue, isA<LoginSuccessState>());
        },
      );
      test(
        "Fail to crete operator, should return null and should emmit a LoginErrorState",
        () async {
          when(usecases.register(any, any)).thenAnswer((_) async => null);
          final result = await store.register(newOperator, "");
          final storeValue = store.value;
          expect(result != null, equals(false));
          expect(storeValue, isA<LoginErrorState>());
        },
      );
    },
  );
  group(
    "Login function should",
    () {
      test(
        "Authenticate user, return an OperatorEntity object and change the value of LoginStoreLoginStore(to LoginSuccessState)",
        () async {
          when(usecases.login(any, any, any))
              .thenAnswer((_) async => usecasesOperator);
          final result = await store.login("email", "password", "collection");
          final storeValue = store.value;
          expect(result != null, equals(true));
          expect(storeValue, isA<LoginSuccessState>());
        },
      );
      test(
        "Fail to Authenticate, return operator object and should emmit a LoginErrorState",
        () async {
          when(usecases.login(any, any, any)).thenAnswer((_) async => null);
          final result = await store.login("", "", "");
          final storeValue = store.value;
          expect(result != null, equals(false));
          expect(storeValue, isA<LoginErrorState>());
        },
      );
    },
  );
}

final usecasesOperator = OperatorEntity(
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
