import 'package:cash_helper_app/app/modules/operator_module/presenter/pages/operator_area.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../presenter/pages/operator_home_page.dart';

abstract class OperatorModuleBinds {
  static routes() => ModuleRoute(
        "/operator-module",
        module: OperatorModule.instance,
        transition: TransitionType.fadeIn,
      );
  static final operatorModule = OperatorModule.instance;
}

class OperatorModule extends Module {
  OperatorModule._();
  static final instance = OperatorModule._();

  @override
  List<Bind<Object>> get binds => bindList;
  @override
  List<ModularRoute> get routes => routeList;

  final routeList = <ModularRoute>[
    ChildRoute(
     "/",
      child: (_, args) => OperartorAreaPage(
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

  final bindList = <Bind>[];
}
