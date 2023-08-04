import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/auth/auth_bloc.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/create_manager_bloc/create_manager_bloc.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/create_operator_bloc/create_operator_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginBlocBinds {
  static final binds = <Bind>[
    Bind.lazySingleton<AuthBloc>((i) => AuthBloc(login: i(), signOut: i())),
    Bind.lazySingleton<CreateManagerBloc>((i) => CreateManagerBloc(registerManager: i())),
    Bind.lazySingleton<CreateOperatorBloc>((i) => CreateOperatorBloc(registerOperator: i())),
  ];
}
