import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';

abstract class CreateAnnotationsStates {}

class CreateAnnotationsInitialState implements CreateAnnotationsStates {}

class CreateAnnotationsLoadingState implements CreateAnnotationsStates {}

class CreateAnnotationsSuccessState implements CreateAnnotationsStates {
  final AnnotationEntity annotation;

 CreateAnnotationsSuccessState(this.annotation);
}
class CreateAnnotationsErrorState implements CreateAnnotationsStates {}
