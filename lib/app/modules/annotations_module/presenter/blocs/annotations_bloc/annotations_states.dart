import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';

abstract class AnnotationsStates {}

class AnnotationsInitialState implements AnnotationsStates {}

class AnnotationsLoadingState implements AnnotationsStates {}

class AnnotationsSuccessState implements AnnotationsStates {
  final AnnotationEntity annotation;

  AnnotationsSuccessState(this.annotation);
}
class AnnotationsErrorState implements AnnotationsStates {}
