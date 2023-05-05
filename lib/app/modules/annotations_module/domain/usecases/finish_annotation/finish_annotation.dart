import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/finish_annotation/ifinish_annotation.dart';

import '../../../../../helpers/data_verifier.dart';
import '../../../infra/data/annotation_repository.dart';

class FinishAnnotation implements IFinishAnnotation {
  FinishAnnotation({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  final _dataVerifier = DataVerifier();
  
   @override
  Future? call(String? operatorId, String? annotationId) async {
    if (_dataVerifier.validateInputData(inputs: [operatorId, annotationId])) {
      await _repository.finishAnnotation(operatorId, annotationId);
    } else {
      return;
    }
  }
}