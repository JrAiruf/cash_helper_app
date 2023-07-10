import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_annotations/iget_all_annotations.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/models/annotation_model.dart';
import 'package:cash_helper_app/app/utils/tests/annotations_test_objects/test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';

class GetAllAnnotationsMock implements IGetAllAnnotations {
  GetAllAnnotationsMock({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  @override
  Future<List<AnnotationEntity>?>? call(
      String? enterpriseId) async {
    if (enterpriseId!.isNotEmpty) {
      final annotationModelList =
          await _repository.getAllAnnotations(enterpriseId);
      final annotationEntityList = annotationModelList
          ?.map((annotationModel) =>
              AnnotationModel.toEntityData(annotationModel))
          .toList();
      return annotationEntityList;
    } else {
      return [];
    }
  }
}

void main() {
  final repository = AnnotationRepo();
  final getAllAnnotations = GetAllAnnotationsMock(repository: repository);
  group(
    "GetAllAnnotations Function Should",
    () {
      test(
        "Return a List<AnnotationEntity>",
        () async {
          when(repository.getAllAnnotations(any)).thenAnswer((_) async => [
            AnnotationsTestObjects.newAnnotationModel,
            AnnotationsTestObjects.newAnnotationModel,
              ]);
          final annotationsList =
              await getAllAnnotations("enterpriseId");
          expect(annotationsList, isA<List<AnnotationEntity>>());
          expect(annotationsList?.isNotEmpty, equals(true));
        },
      );
      test(
        "Fail returning a List<AnnotationEntity>(returns [])",
        () async {
         /*  when(repository.getAllAnnotations(any, any)).thenAnswer((_) async => [
                repositoryAnnotation,
              ]);
          final annotationsList = await getAllAnnotations("", "");
          expect(annotationsList?.isNotEmpty, equals(false)); */
        },
      );
    },
  );
}
