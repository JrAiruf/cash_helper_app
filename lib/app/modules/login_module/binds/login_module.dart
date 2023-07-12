import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases_binds/login_usecases_binds.dart';
import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/external/login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/pages/create_manager_page.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/pages/forgot_password_page.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/pages/create_operator_page.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/pages/login_page.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uuid/uuid.dart';
import '../infra/data/login_repository.dart';
import '../infra/repository/login_repository_impl.dart';
import 'login_prensentation_binds/login_presentation_binds.dart';
import '../presenter/pages/enterprise_auth_page.dart';
import '../presenter/pages/recovery_password_page.dart';

abstract class AppLoginModule {
  static routes() => ModuleRoute(
        Modular.initialRoute,
        module: LoginModule.instance,
        transition: TransitionType.fadeIn,
      );
  static final module = LoginModule.instance;
}

class LoginModule extends Module {
  LoginModule._();
  static final instance = LoginModule._();

  @override
  List<Bind<Object>> get binds => bindList;
  @override
  List<ModularRoute> get routes => routesList;

  final routesList = <ModularRoute>[
    ChildRoute(
      "/create-new-manager",
      child: (_, args) => CreateManagerPage(enterpriseEntity: args.data),
    ),
    ChildRoute(
      "/create-new-operator",
      child: (_, args) => CreateOperatorPage(enterpriseEntity: args.data),
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
      LoginRoutes.login,
      child: (_, args) => LoginPage(enterpriseEntity: args.data),
    ),
    ChildRoute(
      LoginRoutes.initial,
      child: (_, args) => const EnterpriseAuthPage(),
    ),
  ];

  final bindList = <Bind>[
    Bind<FirebaseFirestore>(
      (i) => FirebaseFirestore.instance,
    ),
    Bind<FirebaseAuth>(
      (i) => FirebaseAuth.instance,
    ),
    Bind.singleton<DataVerifier>(
      (i) => DataVerifier(),
    ),
    Bind.singleton<Uuid>(
      (i) => const Uuid(),
    ),
    Bind<ApplicationLoginDatabase>(
      (i) => FirebaseDatabase(
        database: i(),
        auth: i(),
        encryptService: i(),
        uuid: i(),
      ),
    ),
    Bind<LoginRepository>(
      (i) => LoginRepositoryImpl(
        datasource: i(),
        dataVerifier: i(),
      ),
    ),
    ...LoginUsecasesBinds.binds,
    ...LoginPresentationBinds.binds,
  ];
}
