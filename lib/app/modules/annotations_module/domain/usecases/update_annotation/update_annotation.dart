import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/update_annotation/iupdate_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';

import '../../../infra/models/annotation_model.dart';

class UpdateAnnotation implements IUpdateAnnotation {
  UpdateAnnotation({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  final _dataVerifier = DataVerifier();
   @override
  Future<void>? call(String? operatorId, String? annotationId, AnnotationEntity? annotation) async {
     if(_dataVerifier.validateInputData(inputs:[operatorId!,annotationId!])&& annotation != null){
    final annotationModel = AnnotationModel.fromEntityData(annotation);
    await _repository.updateAnnotation(
        operatorId, annotationId, annotationModel);
        } else {
          return;
        }
  }
}
