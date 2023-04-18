import 'package:cash_helper_app/app/modules/operator_module/domain/contract/operator_usecases.dart';
import 'package:cash_helper_app/app/modules/operator_module/external/data/operator_database.dart';
import 'package:cash_helper_app/app/modules/operator_module/external/operator_database_impl.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/controller/operator_controller.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/pages/operator_area.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../domain/usecases/operator_usecases_impl.dart';
import '../infra/data/operator_repository.dart';
import '../infra/repository/operator_repository_impl.dart';
import '../presenter/pages/operator_home_page.dart';
import '../presenter/pages/views/drawer_views/operator_profile_page.dart';
import '../presenter/pages/views/drawer_views/operator_settings_page.dart';
import '../presenter/stores/operator_store.dart';

abstract class OperatorModule {
  static routes() => ModuleRoute(
        "/operator-module",
        module: OperatorModuleCore.instance,
        transition: TransitionType.fadeIn,
      );
  static final binds = OperatorModuleCore.instance.bindList;
}

class OperatorModuleCore extends Module {
  OperatorModuleCore._();
  static final instance = OperatorModuleCore._();

  @override
  List<Bind<Object>> get binds => bindList;
  @override
  List<ModularRoute> get routes => routeList;

  final routeList = <ModularRoute>[
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
      "/operator-area/:operatorId",
      child: (_, args) => OperatorArea(
        operatorId: args.params["operatorId"],
      ),
    ),
  ];

  final bindList = <Bind>[
    Bind<OperatorDatabase>((i) => OperatorDatabaseImpl(auth: i(),datasource: i())),
    Bind<OperatorRepository>((i) => OperatorRepositoryImpl(database: i())),
    Bind<OperatorUsecases>((i) => OperatorUsecasesImpl(repository: i())),
    Bind<OperatorStore>((i) => OperatorStore(usecases: i())),
    Bind.singleton<OperatorController>((i) => OperatorController())
  ];
}
