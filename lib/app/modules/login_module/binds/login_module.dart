import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/login/login.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/register_operator/iregister_operator.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/register_operator/register_operator.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/sign_out/isign_out.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/sign_out/sign_out.dart';
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
import '../domain/usecases/check_operator_data_for_reset_password/check_operator_data_for_reset_password.dart';
import '../domain/usecases/check_operator_data_for_reset_password/icheck_operator_data_for_reset_password.dart';
import '../domain/usecases/get_user_by_id/get_user_by_id.dart';
import '../domain/usecases/get_user_by_id/iget_user_by_id.dart';
import '../domain/usecases/login/ilogin.dart';
import '../domain/usecases/register_manager/iregister_manager.dart';
import '../domain/usecases/register_manager/register_manager.dart';
import '../domain/usecases/reset_operator_password/ireset_operator_password.dart';
import '../domain/usecases/reset_operator_password/reset_operator_password.dart';
import '../infra/data/login_repository.dart';
import '../infra/repository/login_repository_impl.dart';
import '../presenter/controllers/login_controller.dart';
import '../presenter/pages/enterprise_auth_page.dart';
import '../presenter/pages/recovery_password_page.dart';
import '../presenter/stores/login_store.dart';

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
      LoginRoutes.createManager,
      child: (_, args) => CreateManagerPage(enterpriseEntity: args.data),
    ),
    ChildRoute(
      LoginRoutes.createOperator,
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
        uuid: i(),
      ),
    ),
    Bind<LoginRepository>(
      (i) => LoginRepositoryImpl(
        datasource: i(),
        dataVerifier: i(),
      ),
    ),
    Bind<IRegisterOperator>(
      (i) => RegisterOperator(
        repository: i(),
      ),
    ),
    Bind<IRegisterManager>(
      (i) => RegisterManager(
        repository: i(),
      ),
    ),
    Bind<ILogin>(
      (i) => Login(
        repository: i(),
        dataVerifier: i(),
      ),
    ),
    Bind<IGetUserById>(
      (i) => GetUserById(
        repository: i(),
        dataVerifier: i(),
      ),
    ),
    Bind<ICheckOperatorDataForResetPassword>(
      (i) => CheckOperatorDataForResetPassword(
        repository: i(),
      ),
    ),
    Bind<IResetOperatorPassword>(
      (i) => ResetOperatorPassword(
        repository: i(),
      ),
    ),
    Bind<ISignOut>(
      (i) => SignOut(
        repository: i(),
      ),
    ),
    Bind<LoginStore>(
      (i) => LoginStore(
        registerOperator: i(),
        registerManager: i(),
        login: i(),
        getUserById: i(),
        checkOperatorDataForResetPassword: i(),
        resetOperatorPassword: i(),
        signOut: i(),
        dataVerifier: i(),
      ),
    ),
    Bind<LoginController>(
      (i) => LoginController(),
    ),
  ];
}
