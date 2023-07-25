import 'package:flutter_modular/flutter_modular.dart';

import '../usecases/check_operator_data_for_reset_password/check_operator_data_for_reset_password.dart';
import '../usecases/check_operator_data_for_reset_password/icheck_operator_data_for_reset_password.dart';
import '../usecases/get_all_operators/get_all_operators.dart';
import '../usecases/get_all_operators/iget_all_operators.dart';
import '../usecases/get_user_by_id/get_user_by_id.dart';
import '../usecases/get_user_by_id/iget_user_by_id.dart';
import '../usecases/login/ilogin.dart';
import '../usecases/login/login.dart';
import '../usecases/register_manager/iregister_manager.dart';
import '../usecases/register_manager/register_manager.dart';
import '../usecases/register_operator/iregister_operator.dart';
import '../usecases/register_operator/register_operator.dart';
import '../usecases/reset_user_password/ireset_user_password.dart';
import '../usecases/reset_user_password/reset_user_password.dart';
import '../usecases/sign_out/isign_out.dart';
import '../usecases/sign_out/sign_out.dart';

class LoginUsecasesBinds {
  static final binds = <Bind>[
    
    Bind<IRegisterOperator>(
      (i) => RegisterOperator(
        repository: i(),
      ),
    ),
    Bind<IRegisterManager>(
      (i) => RegisterManager(
        repository: i(),
      ),
    ),
    Bind<ILogin>(
      (i) => Login(
        repository: i(),
        dataVerifier: i(),
      ),
    ),
    Bind<IGetUserById>(
      (i) => GetUserById(
        repository: i(),
        dataVerifier: i(),
      ),
    ),
    Bind<ICheckOperatorDataForResetPassword>(
      (i) => CheckOperatorDataForResetPassword(
        repository: i(),
      ),
    ),
    Bind<IResetOperatorPassword>(
      (i) => ResetOperatorPassword(
        repository: i(),
      ),
    ),
    Bind<ISignOut>(
      (i) => SignOut(
        repository: i(),
      ),
    ),
    Bind<IGetAllOperators>(
      (i) => GetAllOperators(
        repository: i(),
      ),
    ),

  ];
}
