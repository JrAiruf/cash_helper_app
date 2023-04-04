import 'package:cash_helper_app/app/cash_helper_app_module.dart';
import 'package:cash_helper_app/shared/themes/color_schemes.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ModularApp(
      module: CashHelperAppModule(),
      child: const CashHelperApp(),
    ),
  );
}

class CashHelperApp extends StatelessWidget {
  const CashHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appBarColor = Color(0xff7144AB);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            bodySmall: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w200),
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(color: appBarColor),
          colorScheme: lightColorScheme),
      darkTheme: ThemeData(
          iconTheme: const IconThemeData(color: Colors.white, size: 35),
          appBarTheme: AppBarTheme(
            color: appBarColor,
            iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.onSecondary,
              size: 30,
            ),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            bodySmall: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w200),
          ),
          useMaterial3: true,
          colorScheme: darkColorScheme),
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}
