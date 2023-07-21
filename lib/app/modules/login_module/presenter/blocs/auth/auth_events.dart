import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';

abstract class AuthEvents {}

class LoginEvent implements AuthEvents {
  final String enterpriseId;
  final String email;
  final String password;
  final String collection;

  LoginEvent(this.enterpriseId, this.email, this.password, this.collection);
}

class RegisterManagerEvent implements AuthEvents {
  final String enterpriseId;
  final ManagerEntity manager;

  RegisterManagerEvent(this.enterpriseId, this.manager);
}

class CreateOperatorEvent implements AuthEvents {
  final String enterpriseId;
  final OperatorEntity newOperator;

  CreateOperatorEvent(this.enterpriseId, this.newOperator);
}

class RetrievePasswordEvent implements AuthEvents {}
class InitialAuthEvent implements AuthEvents {}
