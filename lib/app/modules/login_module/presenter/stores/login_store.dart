import 'package:cash_helper_app/app/modules/login_module/domain/contract/login_usecases.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_operator_by_id/iget_operator_by_id.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/login/ilogin.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/register_operator/iregister_operator.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/reset_operator_password/ireset_operator_password.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/sign_out/isign_out.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_states.dart';
import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/usecases/check_operator_data_for_reset_password/icheck_operator_data_for_reset_password.dart';

class LoginStore extends ValueNotifier<LoginStates?> {
  LoginStore({
    required IRegisterOperator registerOperator,
    required ILogin login,
    required IGetOperatorById getOperatorById,
    required ICheckOperatorDataForResetPassword checkOperatorDataForResetPassword,
    required IResetOperatorPassword resetOperatorPassword,
    required ISignOut signOut,
  })  :_registerOperator = registerOperator,
   _login = login,
   _getOperatorById = getOperatorById,
   _checkOperatorDataForResetPassword = checkOperatorDataForResetPassword,
   _resetOperatorPassword = resetOperatorPassword,
   _signOut = signOut,
        super(LoginInitialState());

  final IRegisterOperator _registerOperator;
  final ILogin _login;
  final IGetOperatorById _getOperatorById;
  final ICheckOperatorDataForResetPassword _checkOperatorDataForResetPassword;
  final IResetOperatorPassword _resetOperatorPassword;
  final ISignOut _signOut;
  bool loadingData = false;

  Future<OperatorEntity?>? register(
      OperatorEntity newOperator, String collection) async {
    value = LoginLoadingState();
    final operatorEntity = await _registerOperator(newOperator, collection);
    operatorEntity != null
        ? value = LoginSuccessState(operatorEntity: operatorEntity)
        : value = LoginErrorState(message: "Usuário não criado");
    return operatorEntity;
  }

  Future<OperatorEntity?>? login(
      String? email, String? password, String? collection) async {
    value = LoginLoadingState();
    final operatorEntity = await _login(email, password, collection);
    operatorEntity != null
        ? value = LoginSuccessState(operatorEntity: operatorEntity)
        : value = LoginErrorState(message: "Usuário não encontrado");
    return operatorEntity;
  }

  Future<void>? getOperatorById(String operatorId, String collection) async {
    value = LoginLoadingState();
    final operatorEntity =
        await _getOperatorById(operatorId, collection);
    operatorEntity != null
        ? value = LoginSuccessState(operatorEntity: operatorEntity)
        : value = LoginErrorState(message: "Usuário não encontrado");
  }

  Future<bool>? checkOperatorDataForResetPassword(
      String email, String operatorCode, String collection) async {
    return await _checkOperatorDataForResetPassword(
        email, operatorCode, collection);
  }

  Future<void>? resetOperatorPassword(
      String email, String operatorCode, String newPassword) async {
    await _resetOperatorPassword(email, operatorCode, newPassword);
  }

  Future<void> signOut() async {
    await _signOut();
    value = null;
  }
}
