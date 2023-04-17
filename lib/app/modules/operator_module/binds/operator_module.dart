import 'package:cash_helper_app/app/modules/operator_module/presenter/controller/operator_controller.dart';
import 'package:cash_helper_app/app/modules/operator_module/presenter/pages/operator_area.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../presenter/pages/operator_home_page.dart';
import '../presenter/pages/views/drawer_views/operator_profile_page.dart';
import '../presenter/pages/views/drawer_views/operator_settings_page.dart';

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
    Bind.singleton<OperatorController>((i) => OperatorController())
  ];
}
