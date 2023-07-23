import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/manager_bloc/manager_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserModuleBlocBinds {
  static final binds = <Bind>[
    Bind.lazySingleton<ManagerBloc>((i) => ManagerBloc(getUserById: i(),signOut: i())),
  ];
}
