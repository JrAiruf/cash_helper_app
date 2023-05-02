import 'package:cash_helper_app/app/modules/login_module/binds/login_module.dart';
import 'package:cash_helper_app/app/modules/user_module/binds/operator_module.dart';
import 'package:cash_helper_app/shared/stores/app_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/annotations_module/binds/annotations_binds.dart';

class CashHelperAppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton<AppStore>((i) => AppStore()),
        ...AppLoginModule.module.bindList,
        ...AppOperatorModule.module.bindList,
        ...AppAnnotationModule.module.bindsList,
      ];
  @override
  List<ModularRoute> get routes => [
        AppLoginModule.routes(),
        AppOperatorModule.routes(),
        AppAnnotationModule.routes(),
      ];
}
