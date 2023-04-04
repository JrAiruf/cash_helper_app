import 'package:cash_helper_app/app/modules/login_module/domain/contract/login_usecases.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/login_usecases_impl.dart';
import 'package:cash_helper_app/app/modules/login_module/presenter/stores/login_store.dart';
import 'package:cash_helper_app/app/modules/operator_module/binds/operator_module_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../login_module/external/data/application_login_database.dart';
import '../../login_module/external/firebase_database.dart';
import '../../login_module/infra/data/login_repository.dart';
import '../../login_module/infra/repository/login_repository_impl.dart';
import '../presenter/pages/home_page.dart';

abstract class OperatorModuleBinds {
  static routes() => ModuleRoute(
        Modular.initialRoute,
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
    ChildRoute(OperatorModuleRoutes.home,
        child: (_, args) => HomePage(
              operatorEntity: args.data,
            )),
  ];

  final bindList = <Bind>[];
}
