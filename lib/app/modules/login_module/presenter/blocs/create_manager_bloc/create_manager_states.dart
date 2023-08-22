import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';

abstract class CreateManagerStates {}

class CreateManagerInitialState implements CreateManagerStates {}

class RedirectingManagerState implements CreateManagerStates {}

// class RedirectingManagerState implements CreateManagerStates {}

class CreateManagerSuccessState implements CreateManagerStates {
  final ManagerEntity manager;

  CreateManagerSuccessState(this.manager);
}

class CreateManagerErrorState implements CreateManagerStates {
  final String error;

  CreateManagerErrorState(this.error);
}
