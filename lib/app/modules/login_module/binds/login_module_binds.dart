import 'package:cash_helper_app/app/modules/login_module/binds/login_module_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class LoginModuleBinds {
  static routes() => ModuleRoute(
        Modular.initialRoute,
        module: LoginModule.instance,
        transition: TransitionType.fadeIn,
      );
  final loginModule = LoginModule.instance;
}

class LoginModule extends Module {
  LoginModule._();
  static final instance = LoginModule._();

  @override
  List<Bind<Object>> get binds => bindList;
  @override
  List<ModularRoute> get routes => routeList;



  final routeList = <ModularRoute>[
    ChildRoute(LoginModuleRoutes.start, child: (_, args) => Container())
  ];
  
  final bindList = <Bind>[
    Bind<FirebaseFirestore>((i) => FirebaseFirestore.instance),
    Bind<FirebaseAuth>((i) => FirebaseAuth.instance),
  ];
}
