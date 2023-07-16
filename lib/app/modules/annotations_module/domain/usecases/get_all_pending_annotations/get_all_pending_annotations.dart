import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_pending_annotations/iget_all_pending_annotations.dart';

import '../../../infra/data/annotation_repository.dart';
import '../../../infra/models/annotation_model.dart';

class GetAllPendingAnnotations implements IGetAllPendingAnnotations {
GetAllPendingAnnotations({required AnnotationRepository repository}) : _repository = repository;

  final AnnotationRepository _repository;

   @override
  Future<List<AnnotationEntity>>? call(String enterpriseId) async {
    final annotationModelList = await _repository.getAllPendingAnnotations(enterpriseId);
    final annotationEntityList = annotationModelList?.map((annotationModel) => AnnotationModel.toEntityData(annotationModel)).toList();
    if (annotationEntityList!.isNotEmpty) {
      return annotationEntityList;
    } else {
      return [];
    }
  }
}
