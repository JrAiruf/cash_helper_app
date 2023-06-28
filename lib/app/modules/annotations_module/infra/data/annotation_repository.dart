import 'package:cash_helper_app/app/modules/annotations_module/infra/models/annotation_model.dart';

abstract class AnnotationRepository {
  Future<AnnotationModel?>? createAnnotation(String enterpriseId, String operatorId, AnnotationModel annotation);
  Future<void>? createPendingAnnotation(String enterpriseId, String operatorId, String annotationId);
  Future<AnnotationModel?>? getAnnotationById(String enterpriseId, String operatorId, String annotationId);
  Future<List<AnnotationModel>?>? getAllAnnotations(String enterpriseId, String operatorId);
  Future<List<AnnotationModel>?>? getAllPendingAnnotations(String enterpriseId);
  Future<List<AnnotationModel>?>? searchAnnotationsByClientAddress(String operatorId, String clientAddress);
  Future<void>? updateAnnotation(String enterpriseId, String operatorId,String annotationId,AnnotationModel? annotation);
  Future<void>? finishAnnotation(String enterpriseId, String operatorId,String annotationId);
  Future<void>? deleteAnnotation(String enterpriseId, String operatorId, String annotationId);
}