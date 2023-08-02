// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_all_operators/iget_all_operators.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:meta/meta.dart';
part 'get_operators_event.dart';
part 'get_operators_state.dart';

class GetOperatorsBloc extends Bloc<GetOperatorsEvents, GetOperatorsState> {
  GetOperatorsBloc({required IGetAllOperators getAllOperators})
      : _getAllOperators = getAllOperators,
        super(GetOperatorsInitialState()) {
    on<GetOperatorsEvent>(_mapGetAllOperatorsEventToState);
  }
  final IGetAllOperators _getAllOperators;
  void _mapGetAllOperatorsEventToState(GetOperatorsEvent event, Emitter<GetOperatorsState> state) async {
    state(GetOperatorsLoadingState());
    final operators = await _getAllOperators(event.enterpriseId)?.catchError((e) {
      state(GetOperatorsFailureState());
      return <OperatorEntity>[];
    });
    if (operators!.isNotEmpty) {
      state(GetOperatorsSuccessState(operators));
    }
  }
}
