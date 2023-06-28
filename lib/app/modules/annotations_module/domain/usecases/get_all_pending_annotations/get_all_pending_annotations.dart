import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_pending_annotations/iget_all_pending_annotations.dart';

import '../../../infra/data/annotation_repository.dart';

class GetAllPendingAnnotations implements IGetAllPendingAnnotations {
GetAllPendingAnnotations({required AnnotationRepository repository}) : _repository = repository;

  final AnnotationRepository _repository;

  @override
  Future<List<AnnotationEntity>>? call(String enterpriseId) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
