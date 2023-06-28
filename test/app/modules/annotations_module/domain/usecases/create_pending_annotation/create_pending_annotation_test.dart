import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/create_pending_annotation/icreate_pending_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/utils/tests/annotations_test_objects/test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';

class CreatePendingAnnotationMock implements ICreatePendingAnnotation {
  CreatePendingAnnotationMock({required AnnotationRepository repository}) : _repository = repository;

  final AnnotationRepository _repository;
  @override
  Future<void> call(String enterpriseId, String operatorId, String annotationId) async {}
}

void main() {
  final repository = AnnotationRepo();
  final createPendingAnnotation = CreatePendingAnnotationMock(repository: repository);
  test(
    "CreatePedingAnnotation Usecase should create a pending annotation",
    () async {
      when(repository.getAllAnnotations(any, any)).thenAnswer(
        (_) async => [
          AnnotationsTestObjects.repositoryAnnotation,
          AnnotationsTestObjects.repositoryAnnotation,
          AnnotationsTestObjects.repositoryAnnotation,
        ],
      );
      when(repository.createPendingAnnotation(any, any, any)).thenReturn(null);
      final list = await repository.getAllAnnotations("enterpriseId", "operatorId");
      expect(list?.length, equals(3));
      await createPendingAnnotation("enterpriseId", "operatorId", "annotationId");
    },
  );
}
