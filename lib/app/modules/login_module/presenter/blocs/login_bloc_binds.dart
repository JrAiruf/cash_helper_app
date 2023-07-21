import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/auth/auth_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginBlocBinds {
  static final binds = <Bind>[
    Bind<AuthBloc>((i) => AuthBloc(login: i()))
  ];
}
