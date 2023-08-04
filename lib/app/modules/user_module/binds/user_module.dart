import 'package:cash_helper_app/app/modules/user_module/binds/manager_child_routes.dart';
import 'package:cash_helper_app/app/modules/user_module/binds/operator_child_routes.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/usecases/open_operator_cash/iopen_operator_cash.dart';
import 'package:cash_helper_app/app/modules/user_module/external/data/operator_database.dart';
import 'package:cash_helper_app/app/modules/user_module/external/operator_database_impl.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/blocs/user_module_bloc_binds.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/operator_controller.dart';
import 'package:cash_helper_app/app/modules/user_module/presenter/controller/payment_methods_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../domain/usecases/change_operator_email/change_operator_email.dart';
import '../domain/usecases/change_operator_email/ichange_operator_email.dart';
import '../domain/usecases/change_operator_password/change_operator_password.dart';
import '../domain/usecases/change_operator_password/ichange_operator_password.dart';
import '../domain/usecases/close_operator_cash/close_operator_cash.dart';
import '../domain/usecases/close_operator_cash/iclose_operator_cash.dart';
import '../domain/usecases/delete_operator_account/delete_operator_account.dart';
import '../domain/usecases/delete_operator_account/idelete_operator_account.dart';
import '../domain/usecases/open_operator_cash/open_operator_cash.dart';
import '../infra/data/operator_repository.dart';
import '../infra/repository/operator_repository_impl.dart';

abstract class AppUserModule {
  static routes() => ModuleRoute(
        "/user-module",
        module: UserModule.instance,
        transition: TransitionType.fadeIn,
      );
  static final module = UserModule.instance;
}

class UserModule extends Module {
  UserModule._();
  static final instance = UserModule._();

  @override
  List<Bind<Object>> get binds => bindList;
  @override
  List<ModularRoute> get routes => routesList;

  final routesList = <ModularRoute>[
    ...ManagerChildRoutes.routes,
    ...OperatorChildRoutes.routes,
  ];

  final bindList = <Bind>[
    Bind<OperatorDatabase>(
      (i) => OperatorDatabaseImpl(
        auth: i(),
        datasource: i(),
      ),
    ),
    Bind<OperatorRepository>(
      (i) => OperatorRepositoryImpl(
        database: i(),
      ),
    ),
    Bind<IOpenOperatorCash>(
      (i) => OpenOperatorCash(
        repository: i(),
      ),
    ),
    Bind<ICloseOperatorCash>(
      (i) => CloseOperatorCash(
        repository: i(),
      ),
    ),
    Bind<IChangeOperatorEmail>(
      (i) => ChangeOperatorEmail(
        repository: i(),
      ),
    ),
    Bind<IChangeOperatorPassword>(
      (i) => ChangeOperatorPassword(
        repository: i(),
      ),
    ),
    Bind<IDeleteOperatorAccount>(
      (i) => DeleteOperatorAccount(
        repository: i(),
      ),
    ),
    Bind.singleton<PaymentMethodsController>(
      (i) => PaymentMethodsController(
        getAllPaymentMethods: i(),
      ),
    ),
    Bind.singleton<OperatorController>(
      (i) => OperatorController(),
    ),
    ...UserModuleBlocBinds.binds,
  ];
}
