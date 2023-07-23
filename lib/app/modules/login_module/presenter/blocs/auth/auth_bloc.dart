import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_user_by_id/iget_user_by_id.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/login/ilogin.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/sign_out/isign_out.dart';
import 'package:cash_helper_app/app/modules/login_module/external/errors/authentication_error.dart';
import 'package:cash_helper_app/app/modules/login_module/external/errors/user_not_found_error.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/auth/auth_events.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/auth/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates?> {
  AuthBloc({
    required ILogin login,
    required ISignOut signOut,
    required IGetUserById getUserById,
  })  : _login = login,
        _getUserById = getUserById,
        _signOut = signOut,
        super(null) {
    on<LoginEvent>(_mapLoginEventToState);
    on<InitialAuthEvent>(_setAuthInitialState);
    on<AuthSignOutEvent>(_mapAuthSignOutEventToState);
    on<AuthGetUserByIdEvent>(_mapGetUserByIdEventToState);
  }

  final ILogin _login;
  final IGetUserById _getUserById;
  final ISignOut _signOut;

  var appUser;

  void _setAuthInitialState(InitialAuthEvent event, Emitter<AuthStates?> state) async {
    state(AuthInitialState());
  }

  void _mapLoginEventToState(LoginEvent event, Emitter<AuthStates?> state) async {
    state(AuthLoadingState());
    appUser = await _login(event.email, event.password, event.enterpriseId, event.collection).catchError(
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

  void _mapGetUserByIdEventToState(AuthGetUserByIdEvent event, Emitter<AuthStates?> state) async {
    state(AuthLoadingState());
    appUser = await _getUserById(event.enterpriseId, event.userId, event.collection);
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

  void _mapAuthSignOutEventToState(AuthSignOutEvent event, Emitter<AuthStates?> state) async {
    state(AuthSignOutState());
    await _signOut();
  }
}
