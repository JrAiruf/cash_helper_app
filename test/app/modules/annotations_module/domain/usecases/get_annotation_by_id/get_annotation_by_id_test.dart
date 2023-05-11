import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_annotation_by_id/iget_annotation_by_id.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/models/annotation_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../../mocks/mocks.dart';
import '../create_annotation/create_annotation_test.dart';

class GetAnnotationByIdMock implements IGetAnnotationById {
  GetAnnotationByIdMock({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  final _dataVerifier = DataVerifier();

  @override
  Future<AnnotationEntity?> call(
      String? operatorId, String? annotationId) async {
      final annotationModel = await _repository.getAnnotationById(operatorId, annotationId);
    if (annotationModel != null && _dataVerifier.validateInputData(inputs: [operatorId, annotationId])) {
      return AnnotationModel.toEntityData(annotationModel);
    } else {
      return null;
    }
  }
}

void main() {
  final repository = AnnotationRepo();
  final createAnnotation = CreateAnnotationUsecaseMock(repository: repository);
  final getAnnotationById = GetAnnotationByIdMock(repository: repository);
  final newAnnotation = AnnotationEntity(
      annotationClientAddress: "Andorinhas 381",
      annotationConcluied: false,
      annotationPaymentMethod: "Dinheiro",
      annotationReminder: "No Reminder",
      annotationSaleDate: "Data Atual",
      annotationSaleTime: "Hora Atual",
      annotationSaleValue: "1455,67");
  group(
    "GetAnnotationById Function Should",
    () {
      test(
        "Return an AnnotationEntity by his id from repository",
        () async {
          when(repository.createAnnotation(any,any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          expect(createdAnnotation?.annotationId != null, equals(true));
          when(repository.getAnnotationById(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final obtainedAnnotation = await getAnnotationById(
              "operatorId", createdAnnotation?.annotationId);
          expect(
              obtainedAnnotation?.annotationPaymentMethod, equals("Dinheiro"));
          expect(obtainedAnnotation?.annotationConcluied, equals(false));
        },
      );
      test(
        "Fail returning AnnotationEntity object from repository",
        () async {
          when(repository.createAnnotation(any,any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          expect(createdAnnotation?.annotationId != null, equals(true));
          when(repository.getAnnotationById(any, any))
              .thenAnswer((_) async => null);
          final obtainedAnnotation =
              await getAnnotationById("", createdAnnotation?.annotationId);
          expect(obtainedAnnotation?.annotationId, equals(null));
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
