import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/update_annotation/iupdate_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/models/annotation_model.dart';
import 'package:flutter_test/flutter_test.dart';

class UpdateAnnotationMock implements IUpdateAnnotation {
  UpdateAnnotationMock({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  final _dataVerifier = DataVerifier();
  @override
  Future<void>? call(String? enterpriseId,String? operatorId, String? annotationId, AnnotationEntity? annotation) async {
     if(_dataVerifier.validateInputData(inputs:[enterpriseId, operatorId,annotationId])&& annotation != null){
    final annotationModel = AnnotationModel.fromEntityData(annotation);
    await _repository.updateAnnotation(enterpriseId!,
        operatorId!, annotationId!, annotationModel);
        } else {
          return;
        }
  }
}
void main() {
  group(
    "UpdateAnnotation Function Should",
    () {
/*       test(
        "Update the respective property passed in object",
        () async {
          when(repository.createAnnotation(any, any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          when(repository.updateAnnotation(any, any, any)).thenReturn(null);
          when(repository.getAnnotationById(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          await updateAnnotation(
              "operatorId", createdAnnotation?.annotationId, createdAnnotation);
          final updatedAnnotation = await getAnnotationById(
              "operatorId", createdAnnotation?.annotationId);
          expect(updatedAnnotation, isA<AnnotationEntity>());
          expect(updatedAnnotation?.annotationReminder, equals(null));
          expect(updatedAnnotation?.annotationConcluied, equals(false));
        },
      );
      test(
        "Fail update properties",
        () async {
          when(repository.createAnnotation(any, any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          when(repository.updateAnnotation(any, any, any)).thenReturn(null);
          when(repository.getAnnotationById(any, any))
              .thenAnswer((_) async => repositoryAnnotationWithNullValue);
          await updateAnnotation("operatorId",
              createdAnnotation?.annotationId, modifiedAnnotation);
          final updatedAnnotation = await getAnnotationById(
              "operatorId", createdAnnotation?.annotationId);
          expect(updatedAnnotation?.annotationPaymentMethod, equals(null));
        },
      ); */
    },
  );
}
