import 'package:cash_helper_app/app/modules/management_module/domain/usecases/get_operator_informations/iget_operators_informations.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/management_states.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:flutter/cupertino.dart';

class ManagementStore extends ValueNotifier<ManagementStates> {
  ManagementStore({required IGetOperatorsInformations getOperatorsInformations})
      : _getOperatorsInformations = getOperatorsInformations,
        super(ManagementInitialState());

  final IGetOperatorsInformations _getOperatorsInformations;

  Future<void> getOperatorsInformations(String enterpriseId) async {
    value = ManagementLoadingState();
    final operatorsList =
        await _getOperatorsInformations(enterpriseId) as List<OperatorEntity>;
    if (operatorsList.isNotEmpty) {
      value = GetUsersListState(operators: operatorsList);
    } else {
      value = GetUsersListFailureState();
    }
  }
}
