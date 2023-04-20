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

  Future<void> changeOperatorEmail(String newEmail, String operatorCode,
      String operatorPassword, String collection) async {
    value = OperatorSettingsLoadingState();
    await Future.delayed(const Duration(seconds: 3));
    if (_validOperatorCredentials(
        newEmail, operatorCode, operatorPassword, collection)) {
      value = OperatorModifiedEmailState();
      return await _usecases.changeOperatorEmail(
          newEmail, operatorCode, operatorPassword, collection);
    } else {
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
