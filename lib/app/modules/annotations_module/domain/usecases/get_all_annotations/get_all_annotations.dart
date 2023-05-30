import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_annotations/iget_all_annotations.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import '../../../infra/models/annotation_model.dart';
import '../../entities/annotation_entity.dart';

class GetAllAnnotations implements IGetAllAnnotations {
  GetAllAnnotations({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  @override
  Future<List<AnnotationEntity>?>? call(
      String? enterpriseId, String? operatorId) async {
    if (enterpriseId!.isNotEmpty && operatorId!.isNotEmpty) {
      final annotationModelList =
          await _repository.getAllAnnotations(enterpriseId, operatorId);
      final annotationEntityList = annotationModelList
          ?.map((annotationModel) =>
              AnnotationModel.toEntityData(annotationModel))
          .toList();
      return annotationEntityList;
    } else {
      return [];
    }
  }
}
