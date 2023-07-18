abstract class ApplicationAnnotationDatabase {
  Future<Map<String, dynamic>?>? createAnnotation(String enterpriseId, Map<String, dynamic> annotation);
  Future<Map<String, dynamic>?>? createPendingAnnotation(String enterpriseId, Map<String, dynamic> annotation);
  Future<Map<String, dynamic>?>? getAnnotationById(String enterpriseId, String annotationId);
  Future<List<Map<String, dynamic>>?>? getAllAnnotations(String enterpriseId);
  Future<List<Map<String, dynamic>>?>? getAllPendingAnnotations(String enterpriseId);
  Future<List<Map<String, dynamic>>?>? searchAnnotationsByClientAddress(String operatorId, String clientAddress);
  Future<void>? updateAnnotation(String entepriseId,String operatorId, String annotationId,Map<String, dynamic> annotation);
  Future<void>? finishAnnotation(String enterpriseId, String operatorId,String annotationId);
  Future<void>? deleteAnnotation(String enterpriseId, String operatorId, String annotationId);
}