import 'package:cash_helper_app/app/modules/login_module/domain/usecases/register_operator/iregister_operator.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/create_operator_bloc/create_operator_events.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/create_operator_bloc/create_operator_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOperatorBloc extends Bloc<CreateOperatorEvents, CreateOperatorStates> {
  CreateOperatorBloc({required IRegisterOperator registerOperator})
      : _registerOperator = registerOperator,
        super(CreateOperatorInitialState()) {
    on<CreateOperatorEvent>(_mapCreateOperatorEventToState);
  }

  final IRegisterOperator _registerOperator;
  void _mapCreateOperatorEventToState(CreateOperatorEvent event, Emitter<CreateOperatorStates> state) async {
    state(CreateOperatorLoadingState());
    final createdOperator = await _registerOperator(event.operatorEntity, event.enterpriseId, event.collection).catchError((e) {
      state(CreateOperatorErrorState(e.toString()));
      return null;
    });
    if (createdOperator != null) {
      state(CreateOperatorSuccessState(createdOperator));
    }
  }
}
