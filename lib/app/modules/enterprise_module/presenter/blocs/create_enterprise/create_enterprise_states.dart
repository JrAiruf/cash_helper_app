import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';

abstract class CreateEnterpriseStates {}

class CreateEnterpriseInitialState implements CreateEnterpriseStates {}
class CreateEnterpriseLoadingState implements CreateEnterpriseStates {}
class CreateEnterpriseSuccessState implements CreateEnterpriseStates {
CreateEnterpriseSuccessState(this.enterprise);
  final EnterpriseEntity enterprise;
}
class CreateEnterpriseErrorState implements CreateEnterpriseStates {
CreateEnterpriseErrorState(this.error);
  final String error;
}