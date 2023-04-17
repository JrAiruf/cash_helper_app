import 'package:cash_helper_app/shared/stores/app_store.dart';
import "package:flutter/material.dart";
import 'package:cash_helper_app/shared/themes/cash_helper_dark_theme.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_light_theme.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CashHelperApp extends StatelessWidget {
  const CashHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
  final controller = context.watch<AppStore>((theme) => theme.appTheme);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: controller.appTheme.value,
      theme: cashHelperLightTheme,
      darkTheme: cashHelperDarkTheme,
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}
