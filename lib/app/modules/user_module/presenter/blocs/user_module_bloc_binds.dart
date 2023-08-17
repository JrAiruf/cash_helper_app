import 'package:cash_helper_app/app/modules/management_module/presenter/blocs/generate_pendency_bloc/generate_pendency_bloc.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/manager_bloc/manager_bloc.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/operator_bloc/operator_bloc.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/operator_oppening_bloc/operator_oppening_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'operator_closing_bloc/operator_closing_bloc.dart';

class UserModuleBlocBinds {
  static final binds = <Bind>[
    Bind.lazySingleton<ManagerBloc>((i) => ManagerBloc(getUserById: i(),signOut: i())),
    Bind.lazySingleton<OperatorBloc>((i) => OperatorBloc(getUserById: i(),signOut: i())),
    Bind.lazySingleton<OperatorOppeningBloc>((i) => OperatorOppeningBloc(openOperatorCash: i(),getUserById: i())),
    Bind.lazySingleton<OperatorClosingBloc>((i) => OperatorClosingBloc(closeOperatorCash: i())),
    Bind.lazySingleton<GeneratePendencyBloc>((i) => GeneratePendencyBloc(generatePendency: i())),
  ];
}
