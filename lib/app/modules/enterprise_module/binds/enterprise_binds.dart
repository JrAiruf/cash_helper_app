import 'package:cash_helper_app/app/modules/enterprise_module/domain/usecases/create_enterprise_account/icreate_enterprise_account.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/domain/usecases/get_enterprise_by_code/iget_enterprise_by_code.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/presenter/blocs/bloc_binds.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/presenter/blocs/create_enterprise/create_enterprise_bloc.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/presenter/blocs/create_enterprise/create_enterprise_bloc.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/presenter/blocs/get_enterprise_by_code/get_enterprise_by_code_bloc.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/presenter/pages/create_enterprise_page.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/presenter/pages/enterprise_error_page.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/presenter/pages/enterprise_formulary_page.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/presenter/stores/enterprise_store.dart';
import 'package:cash_helper_app/app/routes/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/create_enterprise_account/create_enterprise_account.dart';
import '../domain/usecases/get_enterprise_by_code/get_enterprise_by_code.dart';
import '../external/data/application_enterprise_database.dart';
import '../external/enterprise_database.dart';
import '../infra/data/enterprise_repository.dart';
import '../infra/repositories/enterprise_repository_impl.dart';
import '../presenter/controller/enterprise_controller.dart';
import '../presenter/pages/enterprise_created_page.dart';

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
    ChildRoute(
      EnterpriseRoutes.enterpriseFormulary,
      child: (_, args) => const EnterpriseFormularyPage(),
    ),
    ChildRoute(
      EnterpriseRoutes.createEnterprise,
      child: (_, args) => CreateEnterprisePage(enterpriseEntity: args.data),
    ),
    ChildRoute(
      EnterpriseRoutes.enterpriseCreated,
      child: (_, args) => EnterpriseCreatedPage(enterpriseEntity: args.data),
    ),
    ChildRoute(
      EnterpriseRoutes.enterpriseCreated,
      child: (_, args) => EnterpriseErrorPage(errorText: args.data),
    ),
  ];

  final bindList = <Bind>[
    Bind<ApplicationEnterpriseDatabase>(
      (i) => EnterpriseDatabase(
        database: i(),
        auth: i(),
        encryptService: i(),
        uuid: i(),
      ),
    ),
    Bind<EnterpriseRepository>(
      (i) => EnterpriseRepositoryImpl(
        database: i(),
        dataVerifier: i(),
      ),
    ),
    Bind<ICreateEnterpriseAccount>(
      (i) => CreateEnterpriseAccount(
        repository: i(),
      ),
    ),
    Bind<IGetEnterpriseByCode>(
      (i) => GetEnterpriseByCode(
        repository: i(),
      ),
    ),
    Bind<EnterpriseStore>(
      (i) => EnterpriseStore(
        createEnterpriseAccount: i(),
        getEnterpriseByCode: i(),
      ),
    ),
    ...EnterpriseBlocBinds.binds,
    Bind<EnterpriseController>(
      (i) => EnterpriseController(),
    ),
  ];
}
