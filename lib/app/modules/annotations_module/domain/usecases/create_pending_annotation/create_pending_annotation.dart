import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/create_pending_annotation/icreate_pending_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';

class CreatePendingAnnotation implements ICreatePendingAnnotation {
  CreatePendingAnnotation({required AnnotationRepository repository}) : _repository = repository;

  final AnnotationRepository _repository;
  @override
  Future<void> call(String enterpriseId, String operatorId, String annotationId) {
    throw UnimplementedError();
  }
}
