import 'package:cash_helper_app/app/modules/user_module/external/data/operator_database.dart';
import 'package:cash_helper_app/app/modules/user_module/external/operator_database_impl.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/operator_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/pages/manager_section/management_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../routes/app_routes.dart';
import '../domain/usecases/change_operator_email/change_operator_email.dart';
import '../domain/usecases/change_operator_email/ichange_operator_email.dart';
import '../domain/usecases/change_operator_password/change_operator_password.dart';
import '../domain/usecases/change_operator_password/ichange_operator_password.dart';
import '../domain/usecases/delete_operator_account/delete_operator_account.dart';
import '../domain/usecases/delete_operator_account/idelete_operator_account.dart';
import '../infra/data/operator_repository.dart';
import '../infra/repository/operator_repository_impl.dart';
import '../presenter/pages/manager_section/manager_home_page.dart';
import '../presenter/pages/operator-section/operator_area.dart';
import '../presenter/pages/operator-section/operator_home_page.dart';
import '../presenter/pages/operator-section/views/drawer_views/operator_profile_page.dart';
import '../presenter/pages/operator-section/views/drawer_views/operator_settings_page.dart';
import '../presenter/pages/operator-section/views/drawer_views/settings_pages/change_operator_email_page.dart';
import '../presenter/pages/operator-section/views/drawer_views/settings_pages/change_operator_password_page.dart';
import '../presenter/pages/operator-section/views/drawer_views/settings_pages/remove_operator_account_page.dart';
import '../presenter/stores/operator_store.dart';

abstract class AppUserModule {
  static routes() => ModuleRoute(
        "/user-module",
        module: UserModule.instance,
        transition: TransitionType.fadeIn,
      );
  static final module = UserModule.instance;
}

class UserModule extends Module {
  UserModule._();
  static final instance = UserModule._();

  @override
  List<Bind<Object>> get binds => bindList;
  @override
  List<ModularRoute> get routes => routesList;

  final routesList = <ModularRoute>[
    ChildRoute(
      "/manager-home-page/:enterpriseId",
      child: (_, args) => ManagerHomePage(
        managerEntity: args.data,
      ),
    ),
    ChildRoute(
      "/management-page/:enterpriseId",
      child: (_, args) => ManagementPage(
        managerEntity: args.data,
      ),
    ),
    ChildRoute(
      "/operator-home-page/:enterpriseId",
      child: (_, args) => OperartorHomePage(
        operatorEntity: args.data,
      ),
    ),
    ChildRoute(
      "/operator-profile",
      child: (_, args) => OperatorProfilePage(
        operatorEntity: args.data,
      ),
    ),
    ChildRoute(
      "/operator-settings",
      child: (_, args) => OperatorSettingsPage(
        operatorEntity: args.data,
      ),
    ),
    ChildRoute(
      "/change-operator-email",
      child: (_, args) => ChangeOperatorEmailPage(
        operatorEntity: args.data,
      ),
    ),
    ChildRoute(
      "/change-operator-password",
      child: (_, args) => ChangeOperatorPasswordPage(
        operatorEntity: args.data,
      ),
    ),
    ChildRoute(
      "/remove-operator-account",
      child: (_, args) => RemoveOperatorAccountPage(
        operatorEntity: args.data,
      ),
    ),
    ChildRoute(
      "/operator-area",
      child: (_, args) => OperatorArea(
        operatorEntity: args.data,
      ),
    ),
  ];

  final bindList = <Bind>[
    Bind<OperatorDatabase>(
      (i) => OperatorDatabaseImpl(
        auth: i(),
        datasource: i(),
      ),
    ),
    Bind<OperatorRepository>(
      (i) => OperatorRepositoryImpl(
        database: i(),
      ),
    ),
    Bind<IChangeOperatorEmail>(
      (i) => ChangeOperatorEmail(
        repository: i(),
      ),
    ),
    Bind<IChangeOperatorPassword>(
      (i) => ChangeOperatorPassword(
        repository: i(),
      ),
    ),
    Bind<IDeleteOperatorAccount>(
      (i) => DeleteOperatorAccount(
        repository: i(),
      ),
    ),
    Bind<OperatorStore>(
      (i) => OperatorStore(
        changeOperatorEmail: i(),
        changeOperatorPassword: i(),
        deleteOperatorAccount: i(),
      ),
    ),
    Bind.singleton<OperatorController>(
      (i) => OperatorController(),
    )
  ];
}
