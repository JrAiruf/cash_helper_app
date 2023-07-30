import 'package:cash_helper_app/app/modules/login_module/domain/usecases/register_manager/iregister_manager.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/create_manager_bloc/create_manager_events.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/create_manager_bloc/create_manager_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateManagerBloc extends Bloc<CreateManagerEvents, CreateManagerStates> {
  CreateManagerBloc({required IRegisterManager registerManager})
      : _registerManager = registerManager,
        super(CreateManagerInitialState()) {
    on<CreateManagerEvent>(_mapCreateManagerEventToState);
  }

  final IRegisterManager _registerManager;

  void _mapCreateManagerEventToState(CreateManagerEvent event, Emitter<CreateManagerStates> state) async {
    state(CreateManagerLoadingState());
    final createdManager = await _registerManager(event.manager, event.enterpriseId, event.collection).catchError((e) {
      state(CreateManagerErrorState("Não foi possível criar um novo Gerente"));
      return null;
    });
    if (createdManager != null) {
      state(CreateManagerSuccessState(createdManager));
    }
  }
}
