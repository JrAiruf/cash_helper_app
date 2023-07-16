import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_pending_annotations/iget_all_pending_annotations.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/models/annotation_model.dart';
import 'package:cash_helper_app/app/utils/tests/annotations_test_objects/test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';

class GetAllPendingAnnotationsMock implements IGetAllPendingAnnotations {
  GetAllPendingAnnotationsMock({required AnnotationRepository repository}) : _repository = repository;

  final AnnotationRepository _repository;

  @override
  Future<List<AnnotationEntity>>? call(String enterpriseId) async {
    final annotationModelList = await _repository.getAllPendingAnnotations(enterpriseId);
    final annotationEntityList = annotationModelList?.map((annotationModel) => AnnotationModel.toEntityData(annotationModel)).toList();
    if (annotationEntityList!.isNotEmpty) {
      return annotationEntityList;
    } else {
      return [];
    }
  }
}

void main() {
  final repository = AnnotationRepo();
  final getAllPendingAnnotations = GetAllPendingAnnotationsMock(repository: repository);
  test(
    "GetAllPedingAnnotations should return a List<AnnotationEntity>",
    () async {
      when(repository.getAllPendingAnnotations(any)).thenAnswer((_) async => [AnnotationsTestObjects.pendingAnnotationModel]);
      final result = await getAllPendingAnnotations("enterpriseId");
      expect(result, isA<List<AnnotationEntity>>());
    },
  );
}
