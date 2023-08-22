import 'package:bloc/bloc.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/usecases/close_operator_cash/iclose_operator_cash.dart';
import 'package:meta/meta.dart';
part 'operator_closing_events.dart';
part 'operator_closing_states.dart';

class OperatorClosingBloc extends Bloc<OperatorClosingEvent, OperatorClosingStates> {
  OperatorClosingBloc({required ICloseOperatorCash closeOperatorCash})
      : _closeOperatorCash = closeOperatorCash,
        super(OperatorClosingInitialState()) {
    on<OperatorClosingEvent>(_mapOperatorClosingEventToState);
  }

  final ICloseOperatorCash _closeOperatorCash;
  _mapOperatorClosingEventToState(OperatorClosingEvent event, Emitter<OperatorClosingStates> state) async {
    state(OperatorClosingLoadingState());
    await _closeOperatorCash(event.enterpriseId, event.operatorId, event.closingTime).catchError((e) {
      state(OperatorClosingFailureState("O caixa não foi encerrado corretamente"));
    });
    state(OperatorClosingSuccessState());
  }
}
