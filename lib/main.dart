import 'package:cash_helper_app/app/cash_helper_app_module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app/cash_helper_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ModularApp(
      module: CashHelperAppModule(),
      child:const CashHelperApp(),
    ),
  );
}
