import 'package:cash_helper_app/app/modules/login_module/domain/usecases/login/ilogin.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/auth/auth_events.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/auth/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  AuthBloc({required ILogin login})
      : _login = login,
        super(AuthInitialState()) {
    on<LoginEvent>(_mapLoginEventToState);
    on((event, emit) => null);
    on((event, emit) => null);
    on((event, emit) => null);
    on((event, emit) => null);
  }

  final ILogin _login;
  void _mapLoginEventToState(LoginEvent event, Emitter<AuthStates> state) async {
    state(AuthLoadingState());
    final appUser = await _login(event.email, event.password, event.enterpriseId, event.collection);
    if (appUser != null) {
      switch (event.collection) {
        case "operator":
          state(AuthOperatorSuccessState(appUser));
          break;
        case "manager":
          state(AuthManagerSuccessState(appUser));
          break;
      }
    } else {
      state(AuthErrorState("Credenciais inválidas"));
    }
  }
}
