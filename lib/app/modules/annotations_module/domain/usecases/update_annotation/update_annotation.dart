import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/update_annotation/iupdate_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';

import '../../../infra/models/annotation_model.dart';

class UpdateAnnotation implements IUpdateAnnotation {
  UpdateAnnotation({required AnnotationRepository repository}) : _repository = repository;
  final AnnotationRepository _repository;
  @override
  Future<void>? call(String? enterpriseId, AnnotationEntity? annotation) async {
    await _repository.updateAnnotation(enterpriseId!, AnnotationModel.fromEntityData(annotation!));
  }
}
