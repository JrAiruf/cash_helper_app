import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';

abstract class EnterpriseStates {}

class EnterpriseStoreInitialState implements EnterpriseStates {}

class LoadingState implements EnterpriseStates {}

class CreatedEnterpriseState implements EnterpriseStates {
  CreatedEnterpriseState({required this.enterprise});
  final EnterpriseEntity enterprise;
}
class EnterpriseObtainedState implements EnterpriseStates {
  EnterpriseObtainedState({required this.enterprise});
  final EnterpriseEntity enterprise;
}

class CreationFailedState implements EnterpriseStates {}
class EnterpriseAccessFailedState implements EnterpriseStates {}
