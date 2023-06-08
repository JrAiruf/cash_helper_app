abstract class IDeleteAnnotation {
  Future<dynamic>? call(String? enterpriseId, String? operatorId, String? annotationId);
}