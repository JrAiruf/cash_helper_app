import 'package:flutter_modular/flutter_modular.dart';

import '../../presenter/controllers/login_controller.dart';

class LoginPresentationBinds {
  static final binds = <Bind>[
    Bind<LoginController>(
      (i) => LoginController(),
    ),
  ];
}
