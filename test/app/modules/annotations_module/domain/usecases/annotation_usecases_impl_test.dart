import 'package:cash_helper_app/app/modules/annotations_module/domain/contract/annotation_usecases.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/models/annotation_model.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/repository/annotation_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class AnnotationRepo extends Mock implements AnnotationRepositoryImpl {}

class AnnotationUsecasesMock implements AnnotationUsecases {
  AnnotationUsecasesMock({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  @override
  Future<AnnotationEntity?>? createAnnotation(
      String? operatorId, AnnotationEntity? annotation) async {
    if (operatorId!.isNotEmpty && annotation != null) {
      final annotationModel = AnnotationModel.fromEntityData(annotation);
      final usecaseAnnotation = await _repository.createAnnotation(operatorId, annotationModel);
      return AnnotationModel.toEntityData(usecaseAnnotation!);
    } else {
      return null;
    }
  }

  @override
  Future<AnnotationEntity?>? getAnnotationById(
      String? operatorId, String? annotationId) async {
        if (operatorId!.isNotEmpty && annotationId!.isNotEmpty) {
    final annotationModel = await _repository.getAnnotationById(operatorId, annotationId);
    final usecasesAnnotation = AnnotationModel.toEntityData(annotationModel!);
    return usecasesAnnotation;      
        } else {
          return null;
        }
  }

  @override
  Future<List<AnnotationEntity>?>? getAllAnnotations(String? operatorId) async {
    if(operatorId!.isNotEmpty){
    final annotationModelList = await _repository.getAllAnnotations(operatorId);
    final annotationEntityList = annotationModelList
        ?.map(
            (annotationModel) => AnnotationModel.toEntityData(annotationModel))
        .toList();
    return annotationEntityList;
    } else {
      return [];
    }
  }

  @override
  Future<List<AnnotationEntity>?>? searchAnnotationsByClientAddress(
      String? operatorId, String? clientAddress) async {
        if(operatorId!.isNotEmpty && clientAddress!.isNotEmpty){
    final annotationModelList = await _repository
        .searchAnnotationsByClientAddress(operatorId, clientAddress);
    final annotationEntityList = annotationModelList
        ?.map(
            (annotationModel) => AnnotationModel.toEntityData(annotationModel))
        .toList();
    return annotationEntityList;
        } else {
          return [];
        }
  }

  @override
  Future<void>? updateAnnotation(String? operatorId, String? annotationId,
      AnnotationEntity? annotation) async {
        if(operatorId!.isNotEmpty && annotationId!.isNotEmpty){
    final annotationModel = AnnotationModel.fromEntityData(annotation!);
    await _repository.updateAnnotation(
        operatorId, annotationId, annotationModel);
        } else {
          return;
        }
  }

  @override
  Future<void>? finishAnnotation(
      String? operatorId, String? annotationId) async {
    await _repository.finishAnnotation(operatorId, annotationId);
  }

  @override
  Future<void>? deleteAnnotation(
      String? operatorId, String? annotationId) async {
    await _repository.deleteAnnotation(operatorId, annotationId);
  }
}

void main() {
  final repository = AnnotationRepo();
  final usecases = AnnotationUsecasesMock(repository: repository);
  final newAnnotation = AnnotationEntity(
      annotationClientAddress: "Andorinhas 381",
      annotationConcluied: false,
      annotationPaymentMethod: "Dinheiro",
      annotationReminder: null,
      annotationSaleDate: "Data Atual",
      annotationSaleTime: "Hora Atual",
      annotationSaleValue: "1455,67");
      
  final modifiedAnnotation = AnnotationEntity(
      annotationClientAddress: "Andorinhas 381",
      annotationConcluied: true,
      annotationPaymentMethod: null,
      annotationReminder: "Reminder",
      annotationSaleDate: "Data Atual",
      annotationSaleTime: "Hora Atual",
      annotationSaleValue: "1455,67");
  group(
    "CreateAnnotation Function Should",
    () {
      test(
        "Call database to create an annotation and return an AnnotationEntity object",
        () async {
          when(repository.createAnnotation(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await usecases.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          expect(createdAnnotation?.annotationId != null, equals(true));
        },
      );
      test(
        "Fail creating an annotation and returning an AnnotationEntity object(returns Null)",
        () async {
          when(repository.createAnnotation(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await usecases.createAnnotation("", newAnnotation);
          expect(createdAnnotation == null, equals(true));
        },
      );
    },
  );

  group(
    "GetAnnotationById Function Should",
    () {
      test(
        "Return an AnnotationEntity by his id from repository",
        () async {
          when(repository.createAnnotation(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await usecases.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          expect(createdAnnotation?.annotationId != null, equals(true));
          when(repository.getAnnotationById(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final obtainedAnnotation = await usecases.getAnnotationById(
              "operatorId", createdAnnotation?.annotationId);
          expect(
              obtainedAnnotation?.annotationPaymentMethod, equals("Dinheiro"));
          expect(obtainedAnnotation?.annotationConcluied, equals(false));
        },
      );
      test(
        "Fail returning AnnotationEntity object from repository",
        () async {
          when(repository.createAnnotation(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await usecases.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          expect(createdAnnotation?.annotationId != null, equals(true));
          when(repository.getAnnotationById(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final obtainedAnnotation = await usecases.getAnnotationById(
              "", createdAnnotation?.annotationId);
          expect(obtainedAnnotation, equals(null));
        },
      );
    },
  );
  group(
    "GetAllAnnotations Function Should",
    () {
      test(
        "Return a List<AnnotationEntity>",
        () async {
          when(repository.createAnnotation(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await usecases.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          when(repository.getAllAnnotations(any)).thenAnswer((_) async => [
                repositoryAnnotation,
              ]);
          final annotationsList =
              await usecases.getAllAnnotations("operatorId");
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
              await usecases.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          when(repository.getAllAnnotations(any)).thenAnswer((_) async => [
                repositoryAnnotation,
              ]);
          final annotationsList = await usecases.getAllAnnotations("");
          expect(annotationsList?.isNotEmpty, equals(false));
        },
      );
    },
  );
  group(
    "SearchAnnotationsByClientAddress Function Should",
    () {
      test(
        "Return an annotation object from repository, in wich annotationClientAddress property matches with the given text",
        () async {
          when(repository.createAnnotation(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await usecases.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          expect(createdAnnotation?.annotationClientAddress,
              equals("Andorinhas 381"));
          when(repository.searchAnnotationsByClientAddress(any, any))
              .thenAnswer((_) async => [repositoryAnnotation]);
          final suggestedAnnotionAddressList = await usecases
              .searchAnnotationsByClientAddress('operatorId', "Andorinhas");
          expect(suggestedAnnotionAddressList, isA<List<AnnotationEntity>>());
          expect(suggestedAnnotionAddressList?.isNotEmpty, equals(true));
        },
      );
      test(
        "Fail returning an annotation from result search",
        () async {
          when(repository.createAnnotation(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await usecases.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          expect(createdAnnotation?.annotationClientAddress,
              equals("Andorinhas 381"));
          when(repository.searchAnnotationsByClientAddress(any, any))
              .thenAnswer((_) async => [repositoryAnnotation]);
          final suggestedAnnotionAddressList =
              await usecases.searchAnnotationsByClientAddress("operatorId", "");
          expect(suggestedAnnotionAddressList?.isEmpty, equals(true));
        },
      );
    },
  );
  group(
    "UpdateAnnotation Function Should",
    () {
      test(
        "Update the respective property passed in object",
        () async {
          when(repository.createAnnotation(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await usecases.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          when(repository.updateAnnotation(any, any, any)).thenReturn(null);
          when(repository.getAnnotationById(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          await usecases.updateAnnotation(
              "operatorId", createdAnnotation?.annotationId, createdAnnotation);
          final updatedAnnotation = await usecases.getAnnotationById(
              "operatorId", createdAnnotation?.annotationId);
          expect(updatedAnnotation, isA<AnnotationEntity>());
          expect(updatedAnnotation?.annotationReminder, equals(null));
          expect(updatedAnnotation?.annotationConcluied, equals(false));
        },
      );
      test(
        "Fail update properties",
        () async {
          when(repository.createAnnotation(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await usecases.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          when(repository.updateAnnotation(any, any, any)).thenReturn(null);
          when(repository.getAnnotationById(any, any))
              .thenAnswer((_) async => repositoryAnnotationWithNullValue);
          await usecases.updateAnnotation("operatorId",
              createdAnnotation?.annotationId, modifiedAnnotation);
          final updatedAnnotation = await usecases.getAnnotationById(
              "operatorId", createdAnnotation?.annotationId);
          expect(updatedAnnotation?.annotationPaymentMethod, equals(null));
        },
      );
    },
  );
  group(
    "FinishAnnotation Function Should",
    () {
      test(
        "Change the state of annotation(false to true)",
        () async {
          when(repository.createAnnotation(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          when(repository.getAnnotationById(any, any))
              .thenAnswer((_) async => finishedAnnotation);
          final createdAnnotation =
              await usecases.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          when(repository.finishAnnotation(any, any)).thenReturn(null);
          await usecases.finishAnnotation(
              "operatorId", createdAnnotation?.annotationId);
          final usecasesFinishedAnnotation = await usecases.getAnnotationById(
              "operatorId", createdAnnotation?.annotationId);
          expect(usecasesFinishedAnnotation?.annotationConcluied, equals(true));
        },
      );
      test(
        "Fail Finishing the annotation",
        () async {
          when(repository.createAnnotation(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          when(repository.getAnnotationById(any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await usecases.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          when(repository.finishAnnotation(any, any)).thenReturn(null);
          await usecases.finishAnnotation("", createdAnnotation?.annotationId);
          final usecasesFinishedAnnotation = await usecases.getAnnotationById(
              "operatorId", createdAnnotation?.annotationId);
          expect(
              usecasesFinishedAnnotation?.annotationConcluied, equals(false));
        },
      );
    },
  );
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
              await usecases.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          final annotationsList =
              await usecases.getAllAnnotations("operatorId");
          expect(annotationsList, isA<List<AnnotationEntity>>());
          expect(annotationsList?.isNotEmpty, equals(true));
          when(repository.deleteAnnotation(any, any)).thenReturn(null);
          await usecases.deleteAnnotation(
              "operatorId", createdAnnotation?.annotationId);
          when(repository.getAllAnnotations(any)).thenAnswer((_) async => []);
          final currentAnnotationsList =
              await usecases.getAllAnnotations("operatorId");
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
              await usecases.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          final annotationsList =
              await usecases.getAllAnnotations("operatorId");
          expect(annotationsList, isA<List<AnnotationEntity>>());
          expect(annotationsList?.isNotEmpty, equals(true));
          when(repository.deleteAnnotation(any, any)).thenReturn(null);
          await usecases.deleteAnnotation("operatorId", "");
          when(repository.getAllAnnotations(any))
              .thenAnswer((_) async => [repositoryAnnotation]);
          final currentAnnotationsList =
              await usecases.getAllAnnotations("operatorId");
          expect(currentAnnotationsList?.isEmpty, equals(false));
        },
      );
    },
  );
}

final repositoryAnnotationWithNullValue = AnnotationModel(
    annotationId: "askjdfhlakjsdhkajshdgkjahlskjdghla",
    annotationClientAddress: "Andorinhas 381",
    annotationConcluied: false,
    annotationPaymentMethod: null,
    annotationReminder: "Reminder",
    annotationSaleDate: "Data Atual",
    annotationSaleTime: "Hora Atual",
    annotationSaleValue: "1455,67");

final repositoryAnnotation = AnnotationModel(
    annotationId: "askjdfhlakjsdhkajshdgkjahlskjdghla",
    annotationClientAddress: "Andorinhas 381",
    annotationConcluied: false,
    annotationPaymentMethod: "Dinheiro",
    annotationReminder: null,
    annotationSaleDate: "Data Atual",
    annotationSaleTime: "Hora Atual",
    annotationSaleValue: "1455,67");
final finishedAnnotation = AnnotationModel(
    annotationId: "askjdfhlakjsdhkajshdgkjahlskjdghla",
    annotationClientAddress: "Andorinhas 381",
    annotationConcluied: true,
    annotationPaymentMethod: "Dinheiro",
    annotationReminder: null,
    annotationSaleDate: "Data Atual",
    annotationSaleTime: "Hora Atual",
    annotationSaleValue: "1455,67");