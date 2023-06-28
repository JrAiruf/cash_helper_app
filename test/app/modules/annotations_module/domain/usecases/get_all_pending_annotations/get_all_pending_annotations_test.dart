import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_pending_annotations/iget_all_pending_annotations.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../mocks/mocks.dart';

class GetAllPendingAnnotationsMock implements IGetAllPendingAnnotations {
  GetAllPendingAnnotationsMock({required AnnotationRepository repository}) : _repository = repository;

  final AnnotationRepository _repository;

  @override
  Future<List<AnnotationEntity>>? call(String enterpriseId) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

void main() {
  final repository = AnnotationRepo();
  final getAllPendingAnnotations = GetAllPendingAnnotationsMock(repository: repository);
  test(
    "GetAllPedingAnnotations should return a List<AnnotationEntity>",
    () async {},
  );
}
