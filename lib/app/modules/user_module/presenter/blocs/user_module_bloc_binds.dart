import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/manager_bloc/manager_bloc.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/operator_bloc/operator_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserModuleBlocBinds {
  static final binds = <Bind>[
    Bind.lazySingleton<ManagerBloc>((i) => ManagerBloc(getUserById: i(),signOut: i())),
    Bind.lazySingleton<OperatorBloc>((i) => OperatorBloc(getUserById: i(),signOut: i())),
  ];
}
