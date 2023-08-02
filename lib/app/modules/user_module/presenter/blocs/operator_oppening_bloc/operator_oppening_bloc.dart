import 'package:bloc/bloc.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_user_by_id/iget_user_by_id.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/usecases/open_operator_cash/iopen_operator_cash.dart';
import 'package:meta/meta.dart';

part 'operator_oppening_events.dart';
part 'operator_oppening_states.dart';

class OperatorOppeningBloc extends Bloc<OperatorOppeningEvents, OperatorOppeningStates> {
  OperatorOppeningBloc({required IOpenOperatorCash openOperatorCash, required IGetUserById getUserById})
      : _openOperatorCash = openOperatorCash,
        _getUserById = getUserById,
        super(OperatorOppeningInitialState()) {
    on<OperatorOppeningEvent>(_mapOperatorOppeningEventToState);
  }

  final IOpenOperatorCash _openOperatorCash;
  final IGetUserById _getUserById;
  void _mapOperatorOppeningEventToState(OperatorOppeningEvent event, Emitter<OperatorOppeningStates> state) async {
    state(OperatorOppeningLoadingState());
    await _openOperatorCash(
      event.enterpriseId,
      event.operatorEntity.operatorId!,
      event.operatorEntity.operatorOppening!,
    ).catchError((e) {
      state(OperatorOppeningFailureState());
    });
    final currentOperator = await _getUserById(event.enterpriseId, event.operatorEntity.operatorId, event.operatorEntity.businessPosition) as OperatorEntity;
    if (currentOperator.operatorEnabled!) {
      state(OperatorOppeningSuccessState());
    }
  }
}
