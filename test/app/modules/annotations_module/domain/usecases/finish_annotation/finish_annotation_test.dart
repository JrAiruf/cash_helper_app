import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/finish_annotation/ifinish_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/utils/tests/annotations_test_objects/test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../../mocks/mocks.dart';
import '../create_annotation/create_new_annotation_test.dart';
import '../get_annotation_by_id/get_annotation_by_id_test.dart';

class FinishAnnotationMock implements IFinishAnnotation {
  FinishAnnotationMock({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  final _dataVerifier = DataVerifier();
  @override
  Future? call(
      String? enterpriseId, String? operatorId, String? annotationId) async {
    if (_dataVerifier.validateInputData(inputs: [enterpriseId, operatorId, annotationId])) {
      await _repository.finishAnnotation(
          enterpriseId!, operatorId!, annotationId!);
    } else {
      return;
    }
  }
}

void main() {
  final repository = AnnotationRepo();
  final createAnnotation = CreateNewAnnotationMock(repository: repository);
  final getAnnotationById = GetAnnotationByIdMock(repository: repository);
  final finishAnnotation = FinishAnnotationMock(repository: repository);
  group(
    "FinishAnnotation Function Should",
    () {
      test(
        "Change annotation status",
        () async {
          when(repository.createAnnotation(any, any)).thenAnswer(
              (_) async => AnnotationsTestObjects.repositoryAnnotation);
          final createdAnnotation = await createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          when(repository.finishAnnotation(any, any, any)).thenReturn(null);
          when(repository.getAnnotationById(any, any, any)).thenAnswer(
              (_) async => AnnotationsTestObjects.modifiedAnnotationModel);
          await finishAnnotation(
              "enterpriseId", "operatorId", createdAnnotation?.annotationId);
          final finishedAnnotation = await getAnnotationById(
              "enterpriseId", "operatorId", createdAnnotation?.annotationId);
          expect(finishedAnnotation, isA<AnnotationEntity>());
          expect(finishedAnnotation?.annotationConcluied, equals(true));
        },
      );
      test(
        "Fail changing status",
        () async {
        when(repository.createAnnotation(any, any)).thenAnswer(
              (_) async => AnnotationsTestObjects.repositoryAnnotation);
          final createdAnnotation = await createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          when(repository.finishAnnotation(any, any, any)).thenReturn(null);
          when(repository.getAnnotationById(any, any, any)).thenAnswer(
              (_) async => AnnotationsTestObjects.newAnnotationModel);
          await finishAnnotation(
              "enterpriseId", "", createdAnnotation?.annotationId);
          final finishedAnnotation = await getAnnotationById(
              "enterpriseId", "operatorId", createdAnnotation?.annotationId);
          expect(finishedAnnotation, isA<AnnotationEntity>());
          expect(finishedAnnotation?.annotationConcluied, equals(false));
        },
      );
    },
  );
}
