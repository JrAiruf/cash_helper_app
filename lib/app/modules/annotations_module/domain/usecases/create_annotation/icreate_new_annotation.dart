import '../../entities/annotation_entity.dart';

abstract class ICreateNewAnnotation {
  Future<dynamic>? call(String enterpriseId, String operatorId, AnnotationEntity annotation);
}