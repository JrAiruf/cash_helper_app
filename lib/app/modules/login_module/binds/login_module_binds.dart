import 'package:cash_helper_app/app/modules/login_module/binds/login_module_routes.dart';
import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/external/firebase_database.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/pages/create_operator_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../domain/contract/login_usecases.dart';
import '../domain/usecases/login_usecases_impl.dart';
import '../infra/data/login_repository.dart';
import '../infra/repository/login_repository_impl.dart';
import '../presenter/controllers/login_controller.dart';
import '../presenter/stores/login_controller.dart';

abstract class LoginModuleBinds {
  static routes() => ModuleRoute(
        Modular.initialRoute,
        module: LoginModule.instance,
        transition: TransitionType.fadeIn,
      );
  static final loginModule = LoginModule.instance;
}

class LoginModule extends Module {
  LoginModule._();
  static final instance = LoginModule._();

  @override
  List<Bind<Object>> get binds => bindList;
  @override
  List<ModularRoute> get routes => routeList;



  final routeList = <ModularRoute>[
    ChildRoute(LoginModuleRoutes.recoveryPassword, child: (_, args) => Container()),
    ChildRoute(LoginModuleRoutes.start, child: (_, args) => CreateOperatorPage()),
  ];
  
  final bindList = <Bind>[
    Bind<FirebaseFirestore>((i) => FirebaseFirestore.instance),
    Bind<FirebaseAuth>((i) => FirebaseAuth.instance),
    Bind<ApplicationLoginDatabase>((i) => FirebaseDatabase(database: i(), auth: i())),
    Bind<LoginRepository>((i) => LoginRepositoryImpl(datasource: i())),
    Bind<LoginUsecases>((i) => LoginUsecasesImpl(repository: i())),
    Bind<LoginStore>((i) => LoginStore(usecases: i())),
    Bind<LoginController>((i) => LoginController()),
  ];
}
