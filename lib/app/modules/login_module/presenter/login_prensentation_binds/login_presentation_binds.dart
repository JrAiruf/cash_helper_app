import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/login_controller.dart';
import '../stores/login_store.dart';

class LoginPresentationBinds {
  static final binds = <Bind>[
    Bind<LoginStore>(
      (i) => LoginStore(
        registerOperator: i(),
        registerManager: i(),
        login: i(),
        getUserById: i(),
        checkOperatorDataForResetPassword: i(),
        resetOperatorPassword: i(),
        signOut: i(),
        dataVerifier: i(),
        getAllOperators: i(),
      ),
    ),
    Bind<LoginController>(
      (i) => LoginController(),
    ),
  ];
}
