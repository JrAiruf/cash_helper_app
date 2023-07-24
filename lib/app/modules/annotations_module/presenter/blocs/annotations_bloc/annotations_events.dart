import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';

abstract class AnnotationsEvents {}

class CreateAnnotationEvent implements AnnotationsEvents {
  final String enterpriseId;
  final AnnotationEntity annotation;

  CreateAnnotationEvent(this.enterpriseId, this.annotation);
}
