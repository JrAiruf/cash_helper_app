import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/contract/login_usecases.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_operator_by_id/iget_operator_by_id.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/login/ilogin.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/register_manager/iregister_manager.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/register_operator/iregister_operator.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/reset_operator_password/ireset_operator_password.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/sign_out/isign_out.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_states.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/usecases/check_operator_data_for_reset_password/icheck_operator_data_for_reset_password.dart';

class LoginStore extends ValueNotifier<LoginStates?> {
  LoginStore({
    required IRegisterManager registerManager,
    required IRegisterOperator registerOperator,
    required ILogin login,
    required IGetOperatorById getOperatorById,
    required ICheckOperatorDataForResetPassword
        checkOperatorDataForResetPassword,
    required IResetOperatorPassword resetOperatorPassword,
    required ISignOut signOut,
    required DataVerifier dataVerifier,
  })  : _registerOperator = registerOperator,
        _registerManager = registerManager,
        _login = login,
        _getOperatorById = getOperatorById,
        _checkOperatorDataForResetPassword = checkOperatorDataForResetPassword,
        _resetOperatorPassword = resetOperatorPassword,
        _signOut = signOut,
        _dataVerifier = dataVerifier,
        super(LoginInitialState());

  final IRegisterManager _registerManager;
  final IRegisterOperator _registerOperator;
  final ILogin _login;
  final IGetOperatorById _getOperatorById;
  final ICheckOperatorDataForResetPassword _checkOperatorDataForResetPassword;
  final IResetOperatorPassword _resetOperatorPassword;
  final ISignOut _signOut;
  final DataVerifier _dataVerifier;
  bool loadingData = false;

  Future<OperatorEntity?>? register(OperatorEntity newOperator,
      String enterpriseId, String collection) async {
    value = LoginLoadingState();
    final operatorEntity =
        await _registerOperator(newOperator, enterpriseId, collection);
    operatorEntity != null
        ? value = LoginSuccessState(operatorEntity: operatorEntity)
        : value = LoginErrorState();
    return operatorEntity;
  }

  Future<void>? registerManager(
      ManagerEntity newManager, String enterpriseId, String collection) async {
    value = LoginLoadingState();
    final managerEntity =
        await _registerManager(newManager, enterpriseId, collection);
    managerEntity != null
        ? value = ManagerLoginSuccessState(managerEntity: managerEntity)
        : value = LoginErrorState();
  }

  Future<void>? login(String? email, String? password, String? enterpriseId,
      String? collection) async {
    value = LoginLoadingState();
    final loginEntity = await _login(email, password, enterpriseId, collection);
    if (_dataVerifier.operatorEntityVerifier(entity: loginEntity)) {
      value = LoginSuccessState(operatorEntity: loginEntity);
    } else if (_dataVerifier.managerEntityVerifier(entity: loginEntity)) {
      value = ManagerLoginSuccessState(managerEntity: loginEntity);
    } else {
      value = LoginErrorState();
    }
  }

  Future<void>? getOperatorById(
      String enterpriseId, String operatorId, String collection) async {
    value = LoginLoadingState();
    final operatorEntity =
        await _getOperatorById(enterpriseId, operatorId, collection);
    operatorEntity != null
        ? value = LoginSuccessState(operatorEntity: operatorEntity)
        : value = LoginErrorState();
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
