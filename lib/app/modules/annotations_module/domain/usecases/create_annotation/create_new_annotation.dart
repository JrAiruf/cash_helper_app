import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/create_annotation/icreate_new_annotation.dart';

import '../../../infra/data/annotation_repository.dart';
import '../../../infra/models/annotation_model.dart';

class CreateNewAnnotation implements ICreateNewAnnotation {
  CreateNewAnnotation({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  @override
  Future<AnnotationEntity>? call(String? enterpriseId, String? operatorId,
      AnnotationEntity? annotation) async {
    final annotationModel = AnnotationModel.fromEntityData(annotation!);
    final repositoryAnnotation = await _repository.createAnnotation(
        enterpriseId, operatorId, annotationModel);
    return AnnotationModel.toEntityData(repositoryAnnotation!);
  }
}