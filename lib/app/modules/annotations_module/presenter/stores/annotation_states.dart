import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';

abstract class AnnotationsListStates {}

class InitialAnnotationsListState implements AnnotationsListStates {}

class LoadingAnnotationsListState implements AnnotationsListStates {}

class EmptyAnnotationsListState implements AnnotationsListStates {}

class RetrievedAnnotationsListState implements AnnotationsListStates {
  RetrievedAnnotationsListState({required this.annotationsList});
  final List<AnnotationEntity> annotationsList;
}

class ErrorAnnotationsListState implements AnnotationsListStates {}

abstract class AnnotationStates {}

class InitialAnnotationState implements AnnotationStates {}

class LoadingAnnotationState implements AnnotationStates {}

class EmptyAnnotationState implements AnnotationStates {}

class RetrievedAnnotationState implements AnnotationStates {
  RetrievedAnnotationState({required this.annotation});
  final AnnotationEntity annotation;
}

class ErrorAnnotationState implements AnnotationStates {}
