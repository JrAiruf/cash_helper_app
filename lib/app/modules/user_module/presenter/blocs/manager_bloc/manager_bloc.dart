import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_user_by_id/iget_user_by_id.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/sign_out/isign_out.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/manager_bloc/manager_events.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/manager_bloc/manager_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagerBloc extends Bloc<ManagerEvents, ManagerStates> {
  ManagerBloc({
    required IGetUserById getUserById,
    required ISignOut signOut,
  })  : _getUserById = getUserById,
  _signOut = signOut,
        super(ManagerInitialState()) {
    on<GetManagerByIdEvent>(_mapGetUserByIdEventToState);
    on<ManagerSignOutEvent>(_mapManagerSignOutEventToState);
  }

  final IGetUserById _getUserById;
  final ISignOut _signOut;

  void _mapGetUserByIdEventToState(GetManagerByIdEvent event, Emitter<ManagerStates> state) async {
    state(ManagerLoadingState());
    final appUser = await _getUserById(event.enterpriseId, event.managerId, event.collection).catchError((e) {
      state(ManagerErrorState(e.toString()));
    });
    if (appUser != null) {
      state(ManagerSuccessState(appUser));
    }
  }
   void _mapManagerSignOutEventToState(ManagerSignOutEvent event, Emitter<ManagerStates> state) async {
    state(ManagerSignOutState());
    await _signOut();
  }
}
