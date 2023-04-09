import 'package:cash_helper_app/app/modules/login_module/binds/login_module.dart';
import 'package:cash_helper_app/app/modules/operator_module/binds/operator_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/annotations_module/binds/annotations_binds.dart';

class CashHelperAppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        ...LoginModule.binds,
        ...OperatorModule.binds,
        ...AnnotationsModule.binds
      ];
  @override
  List<ModularRoute> get routes => [
        LoginModule.routes(),
        OperatorModule.routes(),
        AnnotationsModule.routes(),
      ];
}
