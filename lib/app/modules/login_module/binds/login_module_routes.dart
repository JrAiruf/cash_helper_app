import 'package:flutter_modular/flutter_modular.dart';

abstract class LoginModuleRoutes {
  static final initial = Modular.initialRoute;
  static const start = "/";
  static const register = "/create-new-operator";
  static const recoveryPassword = "/recover-operator-password";
}
