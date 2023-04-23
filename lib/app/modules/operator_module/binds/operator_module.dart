import 'package:cash_helper_app/app/modules/operator_module/domain/contract/operator_usecases.dart';
import 'package:cash_helper_app/app/modules/operator_module/external/data/operator_database.dart';
import 'package:cash_helper_app/app/modules/operator_module/external/operator_database_impl.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/controller/operator_controller.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/pages/operator_area.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/pages/views/drawer_views/operator_settings_pages/change_operator_email_page.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/pages/views/drawer_views/operator_settings_pages/remove_operator_account_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../domain/usecases/operator_usecases_impl.dart';
import '../infra/data/operator_repository.dart';
import '../infra/repository/operator_repository_impl.dart';
import '../presenter/pages/operator_home_page.dart';
import '../presenter/pages/views/drawer_views/operator_profile_page.dart';
import '../presenter/pages/views/drawer_views/operator_settings_page.dart';
import '../presenter/pages/views/drawer_views/operator_settings_pages/change_operator_password_page.dart';
import '../presenter/stores/operator_store.dart';

abstract class AppOperatorModule {
  static routes() => ModuleRoute(
        "/operator-module",
        module: OperatorModule.instance,
        transition: TransitionType.fadeIn,
      );
  static final module = OperatorModule.instance;
}

class OperatorModule extends Module {
  OperatorModule._();
  static final instance = OperatorModule._();

  @override
  List<Bind<Object>> get binds => bindList;
  @override
  List<ModularRoute> get routes => routesList;

  final routesList = <ModularRoute>[
    ChildRoute(
      "/",
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
      "/operator-area/:operatorId",
      child: (_, args) => OperatorArea(
        operatorId: args.params["operatorId"],
      ),
    ),
  ];

  final bindList = <Bind>[
    Bind<OperatorDatabase>(
        (i) => OperatorDatabaseImpl(auth: i(), datasource: i())),
    Bind<OperatorRepository>((i) => OperatorRepositoryImpl(database: i())),
    Bind<OperatorUsecases>((i) => OperatorUsecasesImpl(repository: i())),
    Bind<OperatorStore>((i) => OperatorStore(usecases: i())),
    Bind.singleton<OperatorController>((i) => OperatorController())
  ];
}
