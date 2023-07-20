import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';

abstract class GetEnterpriseByCodeStates {}

class GetEnterpriseInitialState implements GetEnterpriseByCodeStates{}
class GetEnterpriseLoadingState implements GetEnterpriseByCodeStates{}
class GetEnterpriseErrorState implements GetEnterpriseByCodeStates{
  final String error;

  GetEnterpriseErrorState(this.error);
}
class GetEnterpriseSuccessState implements GetEnterpriseByCodeStates{
  final EnterpriseEntity enterprise;

  GetEnterpriseSuccessState(this.enterprise);
}