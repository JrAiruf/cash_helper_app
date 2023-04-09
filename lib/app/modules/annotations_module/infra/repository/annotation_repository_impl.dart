import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/models/annotation_model.dart';

class AnnotationRepositoryImpl implements AnnotationRepository {
  @override
  Future<AnnotationModel?>? createAnnotation(String? operatorId, AnnotationModel? annotation) {
    // TODO: implement createAnnotation
    throw UnimplementedError();
  }

  @override
  Future<void>? deleteAnnotation(String? operatorId, String? annotationId) {
    // TODO: implement deleteAnnotation
    throw UnimplementedError();
  }

  @override
  Future<void>? finishAnnotation(String? operatorId, String? annotationId) {
    // TODO: implement finishAnnotation
    throw UnimplementedError();
  }

  @override
  Future<List<AnnotationModel>?>? getAllAnnotations(String? operatorId) {
    // TODO: implement getAllAnnotations
    throw UnimplementedError();
  }

  @override
  Future<AnnotationModel?>? getAnnotationById(String? operatorId, String? annotationId) {
    // TODO: implement getAnnotationById
    throw UnimplementedError();
  }

  @override
  Future<List<AnnotationModel>?>? searchAnnotationsByClientAddress(String? operatorId, String? clientAddress) {
    // TODO: implement searchAnnotationsByClientAddress
    throw UnimplementedError();
  }

  @override
  Future<AnnotationModel?>? updateAnnotation(String? operatorId, String? annotationId, AnnotationModel? annotation) {
    // TODO: implement updateAnnotation
    throw UnimplementedError();
  }
}
