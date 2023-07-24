import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_user_by_id/iget_user_by_id.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/sign_out/isign_out.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/operator_bloc/operator_events.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/operator_bloc/operator_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperatorBloc extends Bloc<OperatorEvents,OperatorStates> {
  OperatorBloc({
    required IGetUserById getUserById,
    required ISignOut signOut,
  })  : _getUserById = getUserById,
        _signOut = signOut,
        super(OperatorInitialState()) {
    on<GetOperatorByIdEvent>(_mapGetUserByIdEventToState);
    on<OperatorSignOutEvent>(_mapOperatorSignOutEventToState);
  }

  final IGetUserById _getUserById;
  final ISignOut _signOut;

  void _mapGetUserByIdEventToState(GetOperatorByIdEvent event, Emitter<OperatorStates> state) async {
    state(OperatorLoadingState());
    final appUser = await _getUserById(event.enterpriseId, event.operatorId, event.collection).catchError((e) {
      state(OperatorErrorState(e.toString()));
    });
    if (appUser != null) {
      state(OperatorSuccessState(appUser));
    }
  }

  void _mapOperatorSignOutEventToState(OperatorSignOutEvent event, Emitter<OperatorStates> state) async {
    state(OperatorSignOutState());
    await _signOut();
  }
}
