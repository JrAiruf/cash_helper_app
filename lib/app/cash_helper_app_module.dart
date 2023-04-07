import 'package:cash_helper_app/app/modules/login_module/binds/login_module_binds.dart';
import 'package:cash_helper_app/app/modules/operator_module/binds/operator_module_binds.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/annotations_module/binds/annotations_binds.dart';

class CashHelperAppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        ...LoginModuleBinds.binds,
        ...OperatorModuleBinds.binds,
        ...AnnotationsModuleBinds.binds
      ];
  @override
  List<ModularRoute> get routes => [
        LoginModuleBinds.routes(),
        OperatorModuleBinds.routes(),
        AnnotationsModuleBinds.routes(),
      ];
}
