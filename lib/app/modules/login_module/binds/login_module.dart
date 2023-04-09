import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/external/login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/pages/forgot_password_page.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/pages/create_operator_page.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../domain/contract/login_usecases.dart';
import '../domain/usecases/login_usecases_impl.dart';
import '../infra/data/login_repository.dart';
import '../infra/repository/login_repository_impl.dart';
import '../presenter/controllers/login_controller.dart';
import '../presenter/pages/recovery_password_page.dart';
import '../presenter/stores/login_store.dart';

abstract class LoginModule {
  static routes() => ModuleRoute(
        Modular.initialRoute,
        module: LoginModuleCore.instance,
        transition: TransitionType.fadeIn,
      );
  static final binds = LoginModuleCore.instance.bindList;
}

class LoginModuleCore extends Module {
  LoginModuleCore._();
  static final instance = LoginModuleCore._();

  @override
  List<Bind<Object>> get binds => bindList;
  @override
  List<ModularRoute> get routes => routeList;

  final routeList = <ModularRoute>[
    ChildRoute(
      "/create-new-operator",
      child: (_, args) => const CreateOperatorPage(),
    ),
    ChildRoute(
      "/forgot-password-page",
      child: (_, args) => const ForgotPasswordPage(),
    ),
    ChildRoute(
      "/recovery-password-page",
      child: (_, args) => RecoveryPasswordPage(operatorEntity: args.data),
    ),
    ChildRoute(
      "/",
      child: (_, args) => const LoginPage(),
    ),
  ];

  final bindList = <Bind>[
    Bind<FirebaseFirestore>(
      (i) => FirebaseFirestore.instance,
    ),
    Bind<FirebaseAuth>(
      (i) => FirebaseAuth.instance,
    ),
    Bind<ApplicationLoginDatabase>(
      (i) => FirebaseDatabase(
        database: i(),
        auth: i(),
      ),
    ),
    Bind<LoginRepository>(
      (i) => LoginRepositoryImpl(
        datasource: i(),
      ),
    ),
    Bind<LoginUsecases>(
      (i) => LoginUsecasesImpl(
        repository: i(),
      ),
    ),
    Bind<LoginStore>(
      (i) => LoginStore(
        usecases: i(),
      ),
    ),
    Bind<LoginController>(
      (i) => LoginController(),
    ),
  ];
}
