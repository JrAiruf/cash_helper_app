import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/delete_annotation/idelete_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import '../create_annotation/create_annotation_test.dart';
import '../get_all_annotations/get_all_annotations_test.dart';

class DeleteAnnotationMock implements IDeleteAnnotation {
  DeleteAnnotationMock({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  final _dataVerifier = DataVerifier();
  @override
  Future<void>? call(String? operatorId, String? annotationId) async {
    if (_dataVerifier.validateInputData(inputs: [operatorId, annotationId])) {
      await _repository.deleteAnnotation(operatorId, annotationId);
    } else {
      return;
    }
  }
}

void main() {
  final repository = AnnotationRepo();
  final createAnnotation = CreateAnnotationUsecaseMock(repository: repository);
  final getAllAnnotations = GetAllAnnotationsMock(repository: repository);
  final deleteAnnotation = DeleteAnnotationMock(repository: repository);
  final newAnnotation = AnnotationEntity(
      annotationClientAddress: "Andorinhas 381",
      annotationConcluied: false,
      annotationPaymentMethod: "Dinheiro",
      annotationReminder: null,
      annotationSaleDate: "Data Atual",
      annotationSaleTime: "Hora Atual",
      annotationSaleValue: "1455,67");
  group(
    "DeleteAnnotation Function Should",
    () {
      test(
        "Remove annotation",
        () async {
          when(repository.createAnnotation(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          when(repository.getAllAnnotations(any))
              .thenAnswer((_) async => [repositoryAnnotation]);
          final createdAnnotation =
              await createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          final annotationsList = await getAllAnnotations("operatorId");
          expect(annotationsList, isA<List<AnnotationEntity>>());
          expect(annotationsList?.isNotEmpty, equals(true));
          when(repository.deleteAnnotation(any, any)).thenReturn(null);
          await deleteAnnotation("operatorId", createdAnnotation?.annotationId);
          when(repository.getAllAnnotations(any)).thenAnswer((_) async => []);
          final currentAnnotationsList = await getAllAnnotations("operatorId");
          expect(currentAnnotationsList?.isEmpty, equals(true));
        },
      );
      test(
        "Fail removing annotation",
        () async {
          when(repository.createAnnotation(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          when(repository.getAllAnnotations(any))
              .thenAnswer((_) async => [repositoryAnnotation]);
          final createdAnnotation =
              await createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          final annotationsList = await getAllAnnotations("operatorId");
          expect(annotationsList, isA<List<AnnotationEntity>>());
          expect(annotationsList?.isNotEmpty, equals(true));
          when(repository.deleteAnnotation(any, any)).thenReturn(null);
          await deleteAnnotation("operatorId", "");
          when(repository.getAllAnnotations(any))
              .thenAnswer((_) async => [repositoryAnnotation]);
          final currentAnnotationsList = await getAllAnnotations("operatorId");
          expect(currentAnnotationsList?.isEmpty, equals(false));
        },
      );
    },
  );
}
