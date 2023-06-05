import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_annotation_by_id/iget_annotation_by_id.dart';
import '../../../../../helpers/data_verifier.dart';
import '../../../infra/data/annotation_repository.dart';
import '../../../infra/models/annotation_model.dart';
import '../../entities/annotation_entity.dart';

class GetAnnotationById implements IGetAnnotationById {
GetAnnotationById({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  final _dataVerifier = DataVerifier();
 @override
  Future<AnnotationEntity?> call(String? enterpriseId,
      String? operatorId, String? annotationId) async {
      final annotationModel = await _repository.getAnnotationById(enterpriseId!,operatorId!, annotationId!);
    if (annotationModel != null && _dataVerifier.validateInputData(inputs: [operatorId, annotationId])) {
      return AnnotationModel.toEntityData(annotationModel);
    } else {
      return null;
    }
  }
}