import 'package:cash_helper_app/app/modules/operator_annotations_module/external/data/application_annotations_database.dart';

class FirebaseDatabase implements ApplicationAnnotationDatabase {
  @override
  Future<Map<String, dynamic>?>? createAnnotation(
      String? operatorId, Map<String, dynamic>? annotation) {
    // TODO: implement createAnnotation
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>?>? getAllAnnotations(String? operatorId) {
    // TODO: implement getAllAnnotations
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?>? getAnnotationById(
      String? operatorId, String? annotationId) {
    // TODO: implement getAnnotationById
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>?>? searchAnnotationsByClientAddress(
      String? operatorId, String? clientAddress) {
    // TODO: implement searchAnnotationsByClientAddress
    throw UnimplementedError();
  }

  @override
  Future<void>? finishAnnotation(String? operatorId, String? annotationId) {
    // TODO: implement finishAnnotation
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?>? updateAnnotation(String? operatorId,
      String? annotationId, Map<String, dynamic>? annotation) {
    // TODO: implement updateAnnotation
    throw UnimplementedError();
  }

  @override
  Future<void>? deleteAnnotation(String? operatorId, String? annotationId) {
    // TODO: implement deleteAnnotation
    throw UnimplementedError();
  }
}
