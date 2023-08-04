import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/auth/auth_bloc.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/blocs/auth/auth_states.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:cash_helper_app/shared/stores/app_store.dart';
import "package:flutter/material.dart";
import 'package:cash_helper_app/shared/themes/cash_helper_dark_theme.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_light_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CashHelperApp extends StatelessWidget {
  const CashHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<AppStore>();
    final authBloc = Modular.get<AuthBloc>();
    return BlocConsumer<AuthBloc, AuthStates?>(
      bloc: authBloc,
      listener: (context, state) {
        if (state is AuthSignOutState) {
          Modular.to.navigate(EnterpriseRoutes.initial);
        }
      },
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeMode: controller.appTheme.value,
          theme: cashHelperLightTheme,
          darkTheme: cashHelperDarkTheme,
          routerDelegate: Modular.routerDelegate,
          routeInformationParser: Modular.routeInformationParser,
        );
      },
    );
  }
}
