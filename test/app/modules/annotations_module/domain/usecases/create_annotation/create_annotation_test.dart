import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/create_annotation/icreate_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/models/annotation_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';

class CreateAnnotationUsecaseMock implements ICreateAnnotation {
  CreateAnnotationUsecaseMock({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  final _dataVerifier = DataVerifier();

  @override
  Future<AnnotationEntity?> call(
      String? operatorId, AnnotationEntity? annotation) async {
    final annotationModel =
        AnnotationModel.fromEntityData(annotation ?? AnnotationEntity());
    final usecaseAnnotation =
        await _repository.createAnnotation("", operatorId!, annotationModel);
    if (usecaseAnnotation != null &&
        _dataVerifier.validateInputData(inputs: [operatorId])) {
      return AnnotationModel.toEntityData(usecaseAnnotation);
    } else {
      return null;
    }
  }
}

void main() {
  final repository = AnnotationRepo();
  final createAnnotation = CreateAnnotationUsecaseMock(repository: repository);
  final newAnnotation = AnnotationEntity(
      annotationClientAddress: "Andorinhas 381",
      annotationConcluied: false,
      annotationPaymentMethod: "Dinheiro",
      annotationReminder: "No Reminder",
      annotationSaleDate: "Data Atual",
      annotationSaleTime: "Hora Atual",
      annotationSaleValue: "1455,67");
  group(
    "CreateAnnotation Function Should",
    () {
      test(
        "Call repository to create an annotation and return an AnnotationEntity object",
        () async {
          when(repository.createAnnotation(any, any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          expect(createdAnnotation?.annotationId != null, equals(true));
        },
      );
      test(
        "Fail creating an annotation and returning an AnnotationEntity object(returns Null)",
        () async {
          when(repository.createAnnotation(any, any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation = await createAnnotation("", newAnnotation);
          expect(createdAnnotation, equals(null));
        },
      );
    },
  );
}

final repositoryAnnotation = AnnotationModel(
    annotationId: "askjdfhlakjsdhkajshdgkjahlskjdghla",
    annotationClientAddress: "Andorinhas 381",
    annotationConcluied: false,
    annotationPaymentMethod: "Dinheiro",
    annotationReminder: "No Reminder",
    annotationSaleDate: "Data Atual",
    annotationSaleTime: "Hora Atual",
    annotationSaleValue: "1455,67");
