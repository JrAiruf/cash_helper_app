import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/create_annotation/icreate_annotation.dart';

import '../../../../../helpers/data_verifier.dart';
import '../../../infra/data/annotation_repository.dart';
import '../../../infra/models/annotation_model.dart';

class CreateAnnotation implements ICreateAnnotation {
CreateAnnotation({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  final _dataVerifier = DataVerifier();

  @override
  Future<AnnotationEntity?> call(
      String? operatorId, AnnotationEntity? annotation) async {
    if (annotation != null &&
        _dataVerifier.validateInputData(inputs: [operatorId])) {
      final annotationModel = AnnotationModel.fromEntityData(annotation);
      final usecaseAnnotation =
          await _repository.createAnnotation(operatorId, annotationModel);
      return AnnotationModel.toEntityData(usecaseAnnotation!);
    } else {
      return null;
    }
  }
}