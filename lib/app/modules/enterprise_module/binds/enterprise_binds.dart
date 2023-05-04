import 'package:cash_helper_app/app/modules/enterprise_module/presenter/pages/create_enterprise_page.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../external/data/application_enterprise_database.dart';
import '../external/enterprise_database.dart';
import '../infra/data/enterprise_repository.dart';
import '../infra/repositories/enterprise_repository_impl.dart';

abstract class AppEnterpriseModule {
  static routes() => ModuleRoute(
        Modular.initialRoute,
        module: EnterpriseModule.instance,
        transition: TransitionType.fadeIn,
      );
  static final module = EnterpriseModule.instance;
}

class EnterpriseModule extends Module {
  EnterpriseModule._();
  static final instance = EnterpriseModule._();

  @override
  List<Bind<Object>> get binds => bindList;
  @override
  List<ModularRoute> get routes => routesList;

  final routesList = <ModularRoute>[
    ChildRoute(EnterpriseRoutes.createEnterprise, child:(_,args) => const CreateEnterprisePage())
  ];

  final bindList = <Bind>[
    Bind<ApplicationEnterpriseDatabase>(
      (i) => EnterpriseDatabase(
        database: i(),
        auth: i(),
        uuid: i(),
      ),
    ),
    Bind<EnterpriseRepository>(
      (i) => EnterpriseRepositoryImpl(
        database: i(),
        dataVerifier: i(),
      ),
    ),
  ];
}
