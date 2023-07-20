import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';

abstract class PendencyStates {}

class PendenciesInitialState extends PendencyStates {}

class LoadingPendenciesState extends PendencyStates {}

class NoPendenciesState extends PendencyStates {}

class NoOperatorsState extends PendencyStates {}

class PendenciesListState extends PendencyStates {
  PendenciesListState({required this.operators, required this.pendencies});
  final List<OperatorEntity> operators;
  final List<PendencyEntity> pendencies;
}
