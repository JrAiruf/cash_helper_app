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
  // TODO: implement binds
  List<Bind<Object>> get binds => bindsList;

  @override
  // TODO: implement routes
  List<ModularRoute> get routes => routesList;

  final routesList = <ModularRoute>[];
  
  final bindsList = <Bind>[];
}
