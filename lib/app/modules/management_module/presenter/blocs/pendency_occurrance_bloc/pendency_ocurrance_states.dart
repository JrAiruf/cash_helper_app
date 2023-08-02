part of 'pendency_ocurrance_bloc.dart';

@immutable
abstract class PendencyOcurranceStates {}

class PendencyOcurranceInitialState extends PendencyOcurranceStates {}

class PendencyOcurranceLoadingState extends PendencyOcurranceStates {}

class PendencyOcurranceSuccessState extends PendencyOcurranceStates {
  final List<OperatorEntity> operators;
  final List<AnnotationEntity> annotations;
  final List<PendencyEntity> pendencies;

  PendencyOcurranceSuccessState(this.operators, this.annotations, this.pendencies);
}

class PendencyOcurranceFailureState extends PendencyOcurranceStates {}
