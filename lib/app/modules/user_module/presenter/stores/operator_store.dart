import 'package:cash_helper_app/app/modules/user_module/domain/usecases/change_operator_email/ichange_operator_email.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/usecases/delete_operator_account/idelete_operator_account.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/usecases/open_operator_cash/iopen_operator_cash.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/usecases/open_operator_cash/open_operator_cash.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/stores/operator_store_states.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/usecases/change_operator_password/ichange_operator_password.dart';
import '../../domain/usecases/close_operator_cash/iclose_operator_cash.dart';

class OperatorStore extends ValueNotifier<OperatorStoreStates> {
  OperatorStore({
    required IChangeOperatorEmail changeOperatorEmail,
    required IOpenOperatorCash openOperatorCash,
    required ICloseOperatorCash closeOperatorCash,
    required IChangeOperatorPassword changeOperatorPassword,
    required IDeleteOperatorAccount deleteOperatorAccount,
  })  : _changeOperatorEmail = changeOperatorEmail,
        _openOperatorCash = openOperatorCash,
        _closeOperatorCash = closeOperatorCash,
        _changeOperatorPassword = changeOperatorPassword,
        _deleteOperatorAccount = deleteOperatorAccount,
        super(OperatorSettingsInitialState());

  final IChangeOperatorEmail _changeOperatorEmail;
  final IOpenOperatorCash _openOperatorCash;
  final ICloseOperatorCash _closeOperatorCash;
  final IChangeOperatorPassword _changeOperatorPassword;
  final IDeleteOperatorAccount _deleteOperatorAccount;

  void restartOperatorSettingsPage() {
    value = OperatorSettingsInitialState();
  }

  Future<void> changeOperatorEmail(String newEmail, String operatorCode,
      String currentPassword, String collection) async {
    value = ChangeEmailLoadingState();
    await Future.delayed(const Duration(seconds: 3));
    if (_validOperatorCredentials(
        newEmail, operatorCode, currentPassword, collection)) {
      await _changeOperatorEmail(
          newEmail, operatorCode, currentPassword, collection);
      value = OperatorModifiedEmailState();
    } else {
      return;
    }
  }

  Future<void> openOperatorCash(
      String enterpriseId, String operatorId, String oppeningTime) async {
    value = LoadingCashState();
    await _openOperatorCash(enterpriseId, operatorId, oppeningTime);
    value = OpenedCashState();
  }
  Future<void> closeOperatorCash(
      String enterpriseId, String operatorId, String closingTime) async {
    value = LoadingCashState();
    await _closeOperatorCash(enterpriseId, operatorId, closingTime);
    value = ClosedCashState();
  }

  Future<void> changeOperatorPassword(String newPassword, String operatorCode,
      String currentPassword, String collection) async {
    value = ChangePasswordLoadingState();
    await Future.delayed(const Duration(seconds: 3));
    if (_validOperatorCredentials(
        newPassword, operatorCode, currentPassword, collection)) {
      value = OperatorModifiedPasswordState();
      await _changeOperatorPassword(
          newPassword, operatorCode, currentPassword, collection);
    } else {
      value = OperatorSettingsInitialState();
      return;
    }
  }

  Future<void> deleteOperatorAccount(String operatorCode, String operatorEmail,
      String operatorPassword, String collection) async {
    value = DeleteOperatorAccountLoadingState();
    await Future.delayed(const Duration(seconds: 3));
    if (_validOperatorCredentials(
        operatorCode, operatorEmail, operatorPassword, collection)) {
      value = AccountDeletedState();
      await _deleteOperatorAccount(
          operatorCode, operatorEmail, operatorPassword, collection);
    } else {
      value = OperatorSettingsInitialState();
      return;
    }
  }

  bool _validOperatorCredentials(String newEmail, String operatorCode,
          String operatorPassword, String collection) =>
      newEmail.isNotEmpty &&
      operatorCode.isNotEmpty &&
      operatorPassword.isNotEmpty &&
      collection.isNotEmpty;
}
