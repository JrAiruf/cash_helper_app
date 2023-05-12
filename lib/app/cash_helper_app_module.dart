import 'package:cash_helper_app/app/modules/enterprise_module/binds/enterprise_binds.dart';
import 'package:cash_helper_app/app/modules/login_module/binds/login_module.dart';
import 'package:cash_helper_app/app/modules/user_module/binds/user_module.dart';
import 'package:cash_helper_app/app/services/crypt_serivce.dart';
import 'package:cash_helper_app/app/services/encrypter/encrypt_service.dart';
import 'package:cash_helper_app/shared/stores/app_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/annotations_module/binds/annotations_binds.dart';
import 'modules/management_module/binds/management_module.dart';

class CashHelperAppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton<AppStore>((i) => AppStore()),
        Bind.singleton<ICryptService>((i) => EncryptService()),
        ...AppLoginModule.module.bindList,
        ...AppEnterpriseModule.module.bindList,
        ...AppUserModule.module.bindList,
        ...AppAnnotationModule.module.bindsList,
        ...AppManagementModule.module.bindsList,
      ];
  @override
  List<ModularRoute> get routes => [
        AppEnterpriseModule.routes(),
        AppLoginModule.routes(),
        AppUserModule.routes(),
        AppAnnotationModule.routes(),
        AppManagementModule.routes(),
      ];
}
