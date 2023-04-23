import 'package:cash_helper_app/app/modules/operator_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/stores/operator_store_states.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/contract/operator_usecases.dart';

class OperatorStore extends ValueNotifier<OperatorStoreStates> {
  OperatorStore({required OperatorUsecases usecases})
      : _usecases = usecases,
        super(OperatorSettingsInitialState());
  final OperatorUsecases _usecases;

  void restartOperatorSettingsPage() {
    value = OperatorSettingsInitialState();
  }

  Future<void> changeOperatorEmail(String newEmail, String operatorCode,String currentPassword, String collection) async {
    value = ChangeEmailLoadingState();
    await Future.delayed(const Duration(seconds: 3));
    if (_validOperatorCredentials(
        newEmail, operatorCode, currentPassword, collection)) {
      await _usecases.changeOperatorEmail(newEmail, operatorCode, currentPassword, collection);
      value = OperatorModifiedEmailState();
    } else {
      return;
    }
  }

  Future<void> changeOperatorPassword(String newPassword, String operatorCode,String currentPassword, String collection) async {
    value = ChangePasswordLoadingState();
    await Future.delayed(const Duration(seconds: 3));
    if (_validOperatorCredentials(
        newPassword, operatorCode, currentPassword, collection)) {
      value = OperatorModifiedPasswordState();
      await _usecases.changeOperatorPassword(newPassword, operatorCode, currentPassword, collection);
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
