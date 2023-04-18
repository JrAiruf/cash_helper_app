import 'package:cash_helper_app/app/modules/login_module/domain/contract/login_usecases.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_states.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:flutter/cupertino.dart';

class LoginStore extends ValueNotifier<LoginStates?> {
  LoginStore({required LoginUsecases usecases}) : _usecases = usecases, super(LoginInitialState());

  final LoginUsecases _usecases;
  bool loadingData = false;

  Future<OperatorEntity?>? register(
      OperatorEntity newOperator, String collection) async {
    value = LoginLoadingState();
    final operatorEntity = await _usecases.register(newOperator, collection);
    operatorEntity != null
        ? value = LoginSuccessState(operatorEntity: operatorEntity)
        : value = LoginErrorState(message: "Usuário não criado");
    return operatorEntity;
  }

  Future<OperatorEntity?>? login(
      String? email, String? password, String? collection) async {
    value = LoginLoadingState();
    final operatorEntity = await _usecases.login(email, password, collection);
    operatorEntity != null
        ? value = LoginSuccessState(operatorEntity: operatorEntity)
        : value = LoginErrorState(message: "Usuário não encontrado");
    return operatorEntity;
  }

  Future<void>? getOperatorById(String operatorId, String collection) async {
    value = LoginLoadingState();
    final operatorEntity =
        await _usecases.getOperatorById(operatorId, collection);
    operatorEntity != null
        ? value = LoginSuccessState(operatorEntity: operatorEntity)
        : value = LoginErrorState(message: "Usuário não encontrado");
  }

  Future<bool>? checkOperatorDataForResetPassword(
      String email, String operatorCode, String collection) async {
    return await _usecases.checkOperatorDataForResetPassword(
        email, operatorCode, collection)!;
  }

  Future<void>? resetOperatorPassword(
      String email, String operatorCode, String newPassword) async {
    await _usecases.resetOperatorPassword(email, operatorCode, newPassword);
  }

  Future<void> signOut() async {
    await _usecases.signOut();
    value = null;
  }
}
