import '../../entities/annotation_entity.dart';

abstract class IUpdateAnnotation {
  Future<dynamic>? call(String enterpriseId,AnnotationEntity annotation);
}