import "package:flutter/material.dart";
import 'package:cash_helper_app/shared/themes/cash_helper_dark_theme.dart';
import 'package:cash_helper_app/shared/themes/cash_helper_light_theme.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CashHelperApp extends StatelessWidget {
  const CashHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: cashHelperLightTheme,
      darkTheme: cashHelperDarkTheme,
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}
