import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/update_annotation/iupdate_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/models/annotation_model.dart';
import 'package:cash_helper_app/app/utils/tests/annotations_test_objects/test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import '../create_annotation/create_new_annotation_test.dart';
import '../get_annotation_by_id/get_annotation_by_id_test.dart';

class UpdateAnnotationMock implements IUpdateAnnotation {
  UpdateAnnotationMock({required AnnotationRepository repository}) : _repository = repository;

  final AnnotationRepository _repository;
  final _dataVerifier = DataVerifier();
  @override
  Future<void>? call(String? enterpriseId, String? operatorId, String? annotationId, AnnotationEntity? annotation) async {
    if (_dataVerifier.validateInputData(inputs: [enterpriseId, operatorId, annotationId]) && annotation != null) {
      final annotationModel = AnnotationModel.fromEntityData(annotation);
      await _repository.updateAnnotation(enterpriseId!, operatorId!, annotationId!, annotationModel);
    } else {
      return;
    }
  }
}

void main() {
  final repository = AnnotationRepo();
  final createAnnotation = CreateNewAnnotationMock(repository: repository);
  final getAnnotationById = GetAnnotationByIdMock(repository: repository);
  final updateAnnotation = UpdateAnnotationMock(repository: repository);

  group(
    "UpdateAnnotation Function Should",
    () {
      test(
        "Update the respective property passed in object",
        () async {
          when(repository.createAnnotation(any, any, any)).thenAnswer((_) async => AnnotationsTestObjects.repositoryAnnotation);
          final createdAnnotation = await createAnnotation("enterprise", "operatorId", AnnotationsTestObjects.newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          when(repository.updateAnnotation(any, any, any, any)).thenReturn(null);
          when(repository.getAnnotationById(any, any, any)).thenAnswer((_) async => AnnotationsTestObjects.newAnnotationModel);
          await updateAnnotation("enterpriseId", "operatorId", createdAnnotation?.annotationId, createdAnnotation);
          final updatedAnnotation = await getAnnotationById("enterpriseId", "operatorId", createdAnnotation?.annotationId);
          expect(updatedAnnotation, isA<AnnotationEntity>());
          expect(updatedAnnotation?.annotationReminder, equals(null));
          expect(updatedAnnotation?.annotationConcluied, equals(false));
        },
      );
      test(
        "Fail update properties",
        () async {
          when(repository.createAnnotation(any, any, any)).thenAnswer((_) async => AnnotationsTestObjects.repositoryAnnotation);
          final createdAnnotation = await createAnnotation("enterpriseId", "operatorId", AnnotationsTestObjects.newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          when(repository.updateAnnotation(any, any, any, any)).thenReturn(null);
          when(repository.getAnnotationById(any, any, any)).thenAnswer((_) async => AnnotationsTestObjects.modifiedAnnotationModel);
          await updateAnnotation("enterpriseId", "operatorId", createdAnnotation?.annotationId, AnnotationsTestObjects.newAnnotation);
          final updatedAnnotation = await getAnnotationById("enterpriseId", "operatorId", createdAnnotation?.annotationId);
          expect(updatedAnnotation?.annotationPaymentMethod, equals(null));
        },
      );
    },
  );
}
