import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_all_operators/iget_all_operators.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/pendencies/get_all_pendencies/iget_all_pendencies.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/pendency_states.dart';
import 'package:flutter/cupertino.dart';

class PendenciesListStore extends ValueNotifier<PendencyStates> {
  PendenciesListStore({
    required IGetAllPendencies getAllPendencies,
    required IGetAllOperators getAllOperators,
  })  : _getAllPendencies = getAllPendencies,
        _getAllOperators = getAllOperators,
        super(PendenciesInitialState());
  final IGetAllPendencies _getAllPendencies;
  final IGetAllOperators _getAllOperators;

  Future<void> getAllPendencies(String enterpriseId) async {
    value = LoadingPendenciesState();
    final operatorsList = await _getAllOperators(enterpriseId);
    final pendenciesList = await _getAllPendencies(enterpriseId);
    if (operatorsList!.isNotEmpty && pendenciesList.isNotEmpty) {
      value = PendenciesListState(operators: operatorsList, pendencies: pendenciesList);
    } else {
      value = operatorsList.isEmpty ? NoOperatorsState() : pendenciesList.isEmpty ? NoPendenciesState() : PendenciesInitialState();
    }
  }
}
