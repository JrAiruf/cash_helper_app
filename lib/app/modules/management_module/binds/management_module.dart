import 'package:cash_helper_app/app/modules/management_module/domain/usecases/create_new_payment_method/icreate_new_payment_method.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/get_operator_informations/iget_operators_informations.dart';
import 'package:cash_helper_app/app/modules/management_module/external/data/application_management_database.dart';
import 'package:cash_helper_app/app/modules/management_module/external/management_database.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/repositories/management_repository_impl.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/management_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/create_new_payment_method/create_new_payment_method.dart';
import '../domain/usecases/get_operator_informations/get_operators_informations.dart';

abstract class AppManagementModule {
  static routes() => ModuleRoute(
        "/management-module",
        module: ManagementeModule.instance,
        transition: TransitionType.fadeIn,
      );
  static final module = ManagementeModule.instance;
}

class ManagementeModule extends Module {
  ManagementeModule._();

  static final instance = ManagementeModule._();

  @override
  List<Bind<Object>> get binds => bindsList;

  @override
  List<ModularRoute> get routes => routesList;

  final routesList = <ModularRoute>[];

  final bindsList = <Bind>[
    Bind<ApplicationManagementDatabase>(
      (i) => ManagementDatabase(
        database: i(),
      ),
    ),
    Bind<ManagementRepository>(
      (i) => ManagementRepositoryImpl(
        database: i(),
        dataVerifier: i(),
      ),
    ),
    Bind<IGetOperatorsInformations>(
      (i) => GetOperatorsInformations(
        repository: i(),
      ),
    ),
    Bind<ICreateNewpaymentMethod>(
      (i) => CreateNewpaymentMethod(
        repository: i(),
      ),
    ),
    Bind<ManagementStore>(
      (i) => ManagementStore(
        getOperatorsInformations: i(),
        createNewPaymentMethod: i(),
      ),
    ),
  ];
}
