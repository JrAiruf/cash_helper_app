import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/delete_annotation/idelete_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class DeleteAnnotationMock implements IDeleteAnnotation {
  DeleteAnnotationMock({required AnnotationRepository repository})
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

void main() {
  group(
    "DeleteAnnotation Function Should",
    () {/* 
      test(
        "Remove annotation",
        () async {
          when(repository.createAnnotation(any, any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          when(repository.getAllAnnotations(any,any))
              .thenAnswer((_) async => [repositoryAnnotation]);
          final createdAnnotation =
              await createAnnotation("enterpriseId","operatorId", AnnotationsTestObjects.newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          final annotationsList = await getAllAnnotations("","operatorId");
          expect(annotationsList, isA<List<AnnotationEntity>>());
          expect(annotationsList?.isNotEmpty, equals(true));
          when(repository.deleteAnnotation(any,any, any)).thenReturn(null);
          await deleteAnnotation("enterpriseId","operatorId", createdAnnotation?.annotationId);
          when(repository.getAllAnnotations(any,any)).thenAnswer((_) async => []);
          final currentAnnotationsList = await getAllAnnotations("enterpriseId","operatorId");
          expect(currentAnnotationsList?.isEmpty, equals(true));
        },
      );
      test(
        "Fail removing annotation",
        () async {
          when(repository.createAnnotation(any, any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          when(repository.getAllAnnotations(any,any))
              .thenAnswer((_) async => [repositoryAnnotation]);
          final createdAnnotation =
              await createAnnotation("enterpriseId","operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          final annotationsList = await getAllAnnotations("enterpriseId","operatorId");
          expect(annotationsList, isA<List<AnnotationEntity>>());
          expect(annotationsList?.isNotEmpty, equals(true));
          when(repository.deleteAnnotation(any, any, any)).thenReturn(null);
          await deleteAnnotation("","operatorId", "");
          when(repository.getAllAnnotations(any,any))
              .thenAnswer((_) async => [repositoryAnnotation]);
          final currentAnnotationsList = await getAllAnnotations("","operatorId");
          expect(currentAnnotationsList?.isEmpty, equals(false));
        },
      ); */
    },
  );
}
