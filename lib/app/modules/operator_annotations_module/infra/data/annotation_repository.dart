import 'package:cash_helper_app/app/modules/operator_annotations_module/infra/models/annotation_model.dart';

abstract class AnnotationRepository {
  Future<AnnotationModel?>? createAnnotation(String? operatorId, AnnotationModel? annotation);
  Future<AnnotationModel?>? getAnnotationById(String? operatorId, String? annotationId);
  Future<List<AnnotationModel>?>? getAllAnnotations(String? operatorId);
  Future<List<AnnotationModel>?>? searchAnnotationsByClientAddress(String? operatorId, String? clientAddress);
  Future<AnnotationModel?>? updateAnnotation(String? operatorId,String? annotationId,AnnotationModel? annotation);
  Future<void>? finishAnnotation(String? operatorId,String? annotationId);
  Future<void>? deleteAnnotation(String? operatorId, String? annotationId);
}