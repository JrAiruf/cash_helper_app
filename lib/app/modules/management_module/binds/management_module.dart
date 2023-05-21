import 'package:cash_helper_app/app/modules/management_module/domain/usecases/create_new_payment_method/icreate_new_payment_method.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/get_all_payment_methods/iget_all_payment_methods.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/get_operator_informations/iget_operators_informations.dart';
import 'package:cash_helper_app/app/modules/management_module/external/data/application_management_database.dart';
import 'package:cash_helper_app/app/modules/management_module/external/management_database.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/repositories/management_repository_impl.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/controller/management_controller.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/pages/payment_method.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/pages/payment_methods_page.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/pages/remove_payment_method_page.dart';
import 'package:cash_helper_app/app/modules/management_module/presenter/stores/management_store.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/pages/manager_section/management_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/create_new_payment_method/create_new_payment_method.dart';
import '../domain/usecases/get_all_payment_methods/get_all_payment_methods.dart';
import '../domain/usecases/get_operator_informations/get_operators_informations.dart';
import '../domain/usecases/remove_payment_method/iremove_payment_method.dart';
import '../domain/usecases/remove_payment_method/remove_payment_method.dart';
import '../presenter/pages/create_payment_methods_page.dart';
import '../presenter/stores/payment_methods_list_store.dart';

abstract class AppManagementModule {
  static routes() => ModuleRoute(
        "/management-module",
        module: ManagementModule.instance,
        transition: TransitionType.fadeIn,
      );
  static final module = ManagementModule.instance;
}

class ManagementModule extends Module {
  ManagementModule._();

  static final instance = ManagementModule._();

  @override
  List<Bind<Object>> get binds => bindsList;

  @override
  List<ModularRoute> get routes => routesList;

  final routesList = <ModularRoute>[
    ChildRoute(
      "/payment-methods-page/:enterpriseId",
      child: (_, args) => PaymentMethodsPage(managerEntity: args.data),
    ),
    ChildRoute(
      "/create-payment-method-page/:enterpriseId",
      child: (_, args) => CreatePaymentMethodPage(managerEntity: args.data),
    ),
    ChildRoute(
      "/remove-payment-method-page/:enterpriseId",
      child: (_, args) => RemovePaymentMethodPage(managerEntity: args.data),
    ),
    ChildRoute(
      "/payment-method/:enterpriseId",
      child: (_, args) =>
          PaymentMethod(paymentMethod: args.data["paymentMethodEntity"]),
    ),
  ];
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
    Bind<IGetAllPaymentMethods>(
      (i) => GetAllPaymentMethods(
        repository: i(),
      ),
    ),
    Bind<IRemovePaymentMethod>(
      (i) => RemovePaymentMethod(
        repository: i(),
      ),
    ),
    Bind.factory<PaymentMethodsListStore>(
      (i) => PaymentMethodsListStore(
        getAllPaymentMethods: i(),
      ),
    ),
    Bind<ManagementStore>(
      (i) => ManagementStore(
        getOperatorsInformations: i(),
        createNewPaymentMethod: i(),
        getAllPaymentMethods: i(),
        removePaymentMethod: i(),
      ),
    ),
    Bind<ManagementController>(
      (i) => ManagementController(),
    ),
  ];
}
