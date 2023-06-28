abstract class ICreatePendingAnnotation {
  Future<void> call(String enterpriseId, String operatorId, String annotationId);
}
