import '../../entities/annotation_entity.dart';

abstract class ICreateAnnotation {
  Future<dynamic>? call(String? operatorId, AnnotationEntity? annotation);
}