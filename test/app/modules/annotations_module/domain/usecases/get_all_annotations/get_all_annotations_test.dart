import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_annotations/iget_all_annotations.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/models/annotation_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import '../create_annotation/create_annotation_test.dart';

class GetAllAnnotationsMock implements IGetAllAnnotations {
  GetAllAnnotationsMock({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  @override
  Future<List<AnnotationEntity>?>? call(String? operatorId) async {
    if (operatorId!.isNotEmpty) {
      final annotationModelList =
          await _repository.getAllAnnotations(operatorId);
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
  final createAnnotation = CreateAnnotationUsecaseMock(repository: repository);
  final getAllAnnotations = GetAllAnnotationsMock(repository: repository);
  final newAnnotation = AnnotationEntity(
      annotationClientAddress: "Andorinhas 381",
      annotationConcluied: false,
      annotationPaymentMethod: "Dinheiro",
      annotationReminder: "No Reminder",
      annotationSaleDate: "Data Atual",
      annotationSaleTime: "Hora Atual",
      annotationSaleValue: "1455,67");
  group(
    "GetAllAnnotations Function Should",
    () {
      test(
        "Return a List<AnnotationEntity>",
        () async {
          when(repository.createAnnotation(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          when(repository.getAllAnnotations(any)).thenAnswer((_) async => [
                repositoryAnnotation,
              ]);
          final annotationsList = await getAllAnnotations("operatorId");
          expect(annotationsList, isA<List<AnnotationEntity>>());
          expect(annotationsList?.isNotEmpty, equals(true));
        },
      );
      test(
        "Fail returning a List<AnnotationEntity>(returns [])",
        () async {
          when(repository.createAnnotation(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          when(repository.getAllAnnotations(any)).thenAnswer((_) async => [
                repositoryAnnotation,
              ]);
          final annotationsList = await getAllAnnotations("");
          expect(annotationsList?.isNotEmpty, equals(false));
        },
      );
    },
  );
}
