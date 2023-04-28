import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_operator_by_id/iget_operator_by_id.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/login/login.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/register_operator/iregister_operator.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/register_operator/register_operator.dart';
import 'package:cash_helper_app/app/modules/login_module/external/data/application_login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/external/login_database.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/pages/forgot_password_page.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/pages/create_operator_page.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../domain/contract/login_usecases.dart';
import '../domain/usecases/check_operator_data_for_reset_password/check_operator_data_for_reset_password.dart';
import '../domain/usecases/check_operator_data_for_reset_password/icheck_operator_data_for_reset_password.dart';
import '../domain/usecases/get_operator_by_id/get_operator_by_id.dart';
import '../domain/usecases/login/ilogin.dart';
import '../domain/usecases/login_usecases_impl.dart';
import '../infra/data/login_repository.dart';
import '../infra/repository/login_repository_impl.dart';
import '../presenter/controllers/login_controller.dart';
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
        uuid: i(),
      ),
    ),
    Bind<LoginRepository>(
      (i) => LoginRepositoryImpl(
        datasource: i(),
      ),
    ),
    Bind<IRegisterOperator>(
      (i) => RegisterOperator(
        repository: i(),
      ),
    ),
    Bind<ILogin>(
      (i) => Login(
        repository: i(),
      ),
    ),
    Bind<IGetOperatorById>(
      (i) => GetOperatorById(
        repository: i(),
      ),
    ),
    Bind<ICheckOperatorDataForResetPassword>(
      (i) => CheckOperatorDataForResetPassword(
        repository: i(),
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
        registerOperator: i(),
        login: i(),
        getOperatorById: i(),
        checkOperatorDataForResetPassword: i(),
      ),
    ),
    Bind<LoginController>(
      (i) => LoginController(),
    ),
  ];
}
