import 'package:cash_helper_app/app/modules/login_module/domain/usecases/login/ilogin.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/sign_out/isign_out.dart';
import 'package:cash_helper_app/app/modules/login_module/external/errors/authentication_error.dart';
import 'package:cash_helper_app/app/modules/login_module/external/errors/user_not_found_error.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/auth/auth_events.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/auth/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  AuthBloc({
    required ILogin login,
    required ISignOut signOut,
  })  : _login = login,
        _signOut = signOut,
        super(AuthInitialState()) {
    on<LoginEvent>(_mapLoginEventToState);
    on<InitialAuthEvent>(_setAuthInitialState);
    on<AuthSignOutEvent>(_mapAuthSignOutEventToState);
  }

  final ILogin _login;
  final ISignOut _signOut;

  void _setAuthInitialState(InitialAuthEvent event, Emitter<AuthStates> state) async {
    state(AuthInitialState());
  }

  void _mapLoginEventToState(LoginEvent event, Emitter<AuthStates> state) async {
    state(AuthLoadingState());
    final appUser = await _login(event.email, event.password, event.enterpriseId, event.collection).catchError(
      (e) {
        if (e.runtimeType == AuthenticationError) {
          state(AuthErrorState("Email ou senha inválidos. Verifique os dados e tente novamente."));
        }
        if (e.runtimeType == UserNotFound) {
          state(AuthBusinessPositionErrorState("Especifique sua função para realizar o login."));
        }
      },
    );
    if (appUser != null) {
      switch (event.collection) {
        case "operator":
          state(AuthOperatorSuccessState(appUser));
          break;
        case "manager":
          state(AuthManagerSuccessState(appUser));
          break;
      }
    }
  }

  void _mapAuthSignOutEventToState(AuthSignOutEvent event, Emitter<AuthStates> state) async {
    state(AuthLoadingState());
    await _signOut();
    state(AuthSignOutState());
  }
}
