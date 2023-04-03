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
    final appBarColor = Theme.of(context).colorScheme.onPrimary;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:const TextTheme(bodyLarge: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),
          useMaterial3: true,
          appBarTheme: AppBarTheme(color: appBarColor),
          colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}
