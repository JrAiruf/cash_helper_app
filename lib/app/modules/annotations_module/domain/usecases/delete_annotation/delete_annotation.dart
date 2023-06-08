import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/delete_annotation/idelete_annotation.dart';

import '../../../../../helpers/data_verifier.dart';
import '../../../infra/data/annotation_repository.dart';

class DeleteAnnotation implements IDeleteAnnotation {
  DeleteAnnotation({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  final _dataVerifier = DataVerifier();

  @override
  Future<void>? call(String? enterpriseId, String? operatorId, String? annotationId) async {
    if (_dataVerifier.validateInputData(inputs: [enterpriseId, operatorId, annotationId])) {
      await _repository.deleteAnnotation(enterpriseId!, operatorId!, annotationId!);
    } else {
      return;
    }
  }
}
