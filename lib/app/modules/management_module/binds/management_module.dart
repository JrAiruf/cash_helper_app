import 'package:flutter_modular/flutter_modular.dart';

abstract class AppManagementModule {
  static routes() => ModuleRoute(
        "/management-module",
        module: ManagementeModule.instance,
        transition: TransitionType.fadeIn,
      );
}

class ManagementeModule extends Module {
  ManagementeModule._();

  static final instance = ManagementeModule._();

  @override
  List<Bind<Object>> get binds => bindsList;

  @override
  List<ModularRoute> get routes => routesList;

  final routesList = <ModularRoute>[];
  
  final bindsList = <Bind>[];
}
