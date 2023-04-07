import 'package:cash_helper_app/app/modules/operator_annotations_module/domain/entities/annotation_entity.dart';

abstract class AnnotationUsecases {
  Future<AnnotationEntity?>? createAnnotation(String? operatorId, AnnotationEntity? annotation);
  Future<AnnotationEntity?>? getAnnotationById(String? operatorId, String? annotationId);
  Future<List<AnnotationEntity>?>? getAllAnnotations(String? operatorId);
  Future<List<AnnotationEntity>?>? searchAnnotationsByClientAddress(String? operatorId, String? clientAddress);
  Future<AnnotationEntity?>? updateAnnotation(String? operatorId,String? annotationId,AnnotationEntity? annotation);
  Future<void>? finishAnnotation(String? operatorId,String? annotationId);
  Future<void>? deleteAnnotation(String? operatorId, String? annotationId);
}