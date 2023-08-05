part of 'get_annotations_bloc.dart';

@immutable
abstract class GetAnnotationsStates {}

class GetAnnotationsInitialState extends GetAnnotationsStates {}

class GetAnnotationsLoadingState extends GetAnnotationsStates {}

class GetAnnotationsFailureState extends GetAnnotationsStates {
  final String error;

  GetAnnotationsFailureState(this.error);
}

class GetAnnotationsSuccessState extends GetAnnotationsStates {
  final List<AnnotationEntity> annotations;

  GetAnnotationsSuccessState(this.annotations);
}
