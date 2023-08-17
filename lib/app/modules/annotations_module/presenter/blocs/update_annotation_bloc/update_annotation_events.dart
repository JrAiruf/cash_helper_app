part of 'update_annotation_bloc.dart';

@immutable
abstract class UpdateAnnotationEvents {}

class UpdateAnnotationEvent implements UpdateAnnotationEvents {
  final String enterpriseId;
  final AnnotationEntity annotation;

  UpdateAnnotationEvent(this.enterpriseId, this.annotation);
}
