import 'package:cash_helper_app/app/modules/annotations_module/external/annotations_database.dart';
import 'package:cash_helper_app/app/modules/annotations_module/external/data/application_annotations_database.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/models/annotation_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class AnnotationsDatabaseMock extends Mock implements AnnotationsDatabase {}

class AnnotationsRepositoryMock implements AnnotationRepository {
  AnnotationsRepositoryMock({required ApplicationAnnotationDatabase datasource})
      : _datasource = datasource;
  final ApplicationAnnotationDatabase _datasource;
  @override
  Future<AnnotationModel?>? createAnnotation(
      String? operatorId, AnnotationModel? annotation) async {
    final datasourceAnnotation =
        await _datasource.createAnnotation(operatorId, annotation?.toMap());
    if (operatorId!.isNotEmpty && annotation!.toMap().isNotEmpty) {
      return AnnotationModel.fromMap(datasourceAnnotation!);
    } else {
      return null;
    }
  }

  @override
  Future<AnnotationModel?>? getAnnotationById(
      String? operatorId, String? annotationId) async {
    final datasourceAnnotation =
        await _datasource.getAnnotationById(operatorId, annotationId);
    if (operatorId!.isNotEmpty && annotationId!.isNotEmpty) {
      return AnnotationModel.fromMap(datasourceAnnotation!);
    } else {
      return null;
    }
  }

  @override
  Future<List<AnnotationModel>?>? getAllAnnotations(String? operatorId) async {
    final datasoourceAnnotationsList =
        await _datasource.getAllAnnotations(operatorId);
    if (operatorId!.isNotEmpty) {
      final annotationsModelList = datasoourceAnnotationsList
          ?.map((annotationMap) => AnnotationModel.fromMap(annotationMap))
          .toList();
      return annotationsModelList;
    } else {
      return [];
    }
  }

  @override
  Future<List<AnnotationModel>?>? searchAnnotationsByClientAddress(
      String? operatorId, String? clientAddress) async {
    final datasourceSugestedMaps = await _datasource
        .searchAnnotationsByClientAddress(operatorId, clientAddress);
    if (operatorId!.isNotEmpty && clientAddress!.isNotEmpty) {
      final repositorySugestedAnnotations = datasourceSugestedMaps
          ?.map((annotationMap) => AnnotationModel.fromMap(annotationMap))
          .toList();
      return repositorySugestedAnnotations;
    } else {
      return [];
    }
  }

  @override
  Future<void>? updateAnnotation(String? operatorId, String? annotationId,
      AnnotationModel? annotation) async {
    if (annotationId!.isNotEmpty &&
        !annotation!.toMap().values.contains(null)) {
      await _datasource.updateAnnotation(
          operatorId, annotationId, annotation.toMap());
    } else {
      return;
    }
  }

  @override
  Future<void>? finishAnnotation(
      String? operatorId, String? annotationId) async {
    if (operatorId!.isNotEmpty && annotationId!.isNotEmpty) {
      await _datasource.finishAnnotation(operatorId, annotationId);
    } else {
      return;
    }
  }

  @override
  Future<void>? deleteAnnotation(
      String? operatorId, String? annotationId) async {
    if (operatorId!.isNotEmpty && annotationId!.isNotEmpty) {
      await _datasource.deleteAnnotation(operatorId, annotationId);
    } else {
      return;
    }
  }
}

void main() {
  final datasource = AnnotationsDatabaseMock();
  final repository = AnnotationsRepositoryMock(datasource: datasource);
  final newAnnotation = AnnotationModel(
      annotationClientAddress: "Andorinhas 381",
      annotationConcluied: false,
      annotationPaymentMethod: "Dinheiro",
      annotationReminder: null,
      annotationSaleDate: "Data Atual",
      annotationSaleTime: "Hora Atual",
      annotationSaleValue: "1455,67");
  final modifiedAnnotation = AnnotationModel(
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
        "Call database to create an annotation and return an AnnotationModel object",
        () async {
          when(datasource.createAnnotation(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          final createdAnnotation =
              await repository.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationModel>());
          expect(createdAnnotation?.annotationId != null, equals(true));
        },
      );
      test(
        "Fail creating an annotation and returning an AnnotationModel object(returns Null)",
        () async {
          when(datasource.createAnnotation(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          final createdAnnotation =
              await repository.createAnnotation("", newAnnotation);
          expect(createdAnnotation == null, equals(true));
        },
      );
    },
  );

  group(
    "GetAnnotationById Function Should",
    () {
      test(
        "Return an AnnotationModel by his id from datasource",
        () async {
          when(datasource.createAnnotation(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          final createdAnnotation =
              await repository.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationModel>());
          expect(createdAnnotation?.annotationId != null, equals(true));
          when(datasource.getAnnotationById(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          final obtainedAnnotation = await repository.getAnnotationById(
              "operatorId", createdAnnotation?.annotationId);
          expect(
              obtainedAnnotation?.annotationPaymentMethod, equals("Dinheiro"));
          expect(obtainedAnnotation?.annotationConcluied, equals(false));
        },
      );
      test(
        "Fail returning AnnotationModel object from datasource",
        () async {
          when(datasource.createAnnotation(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          final createdAnnotation =
              await repository.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationModel>());
          expect(createdAnnotation?.annotationId != null, equals(true));
          when(datasource.getAnnotationById(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          final obtainedAnnotation = await repository.getAnnotationById(
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
        "Return a List<AnnotationModel>",
        () async {
          when(datasource.createAnnotation(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          final createdAnnotation =
              await repository.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationModel>());
          when(datasource.getAllAnnotations(any)).thenAnswer((_) async => [
                databaseAnnotation,
              ]);
          final annotationsList =
              await repository.getAllAnnotations("operatorId");
          expect(annotationsList, isA<List<AnnotationModel>>());
          expect(annotationsList?.isNotEmpty, equals(true));
        },
      );
      test(
        "Fail returning a List<AnnotationModel>(returns [])",
        () async {
          when(datasource.createAnnotation(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          final createdAnnotation =
              await repository.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationModel>());
          when(datasource.getAllAnnotations(any)).thenAnswer((_) async => [
                databaseAnnotation,
              ]);
          final annotationsList = await repository.getAllAnnotations("");
          expect(annotationsList?.isNotEmpty, equals(false));
        },
      );
    },
  );
  group(
    "SearchAnnotationsByClientAddress Function Should",
    () {
      test(
        "Return an annotation object from datasource, in wich annotationClientAddress property matches with the given text",
        () async {
          when(datasource.createAnnotation(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          final createdAnnotation =
              await repository.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationModel>());
          expect(createdAnnotation?.annotationClientAddress,
              equals("Andorinhas 381"));
          when(datasource.searchAnnotationsByClientAddress(any, any))
              .thenAnswer((_) async => [databaseAnnotation]);
          final suggestedAnnotionAddressList = await repository
              .searchAnnotationsByClientAddress('operatorId', "Andorinhas");
          expect(suggestedAnnotionAddressList, isA<List<AnnotationModel>>());
          expect(suggestedAnnotionAddressList?.isNotEmpty, equals(true));
        },
      );
      test(
        "Fail returning an annotation from result search",
        () async {
          when(datasource.createAnnotation(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          final createdAnnotation =
              await repository.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationModel>());
          expect(createdAnnotation?.annotationClientAddress,
              equals("Andorinhas 381"));
          when(datasource.searchAnnotationsByClientAddress(any, any))
              .thenAnswer((_) async => [databaseAnnotation]);
          final suggestedAnnotionAddressList = await repository
              .searchAnnotationsByClientAddress("operatorId", "");
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
          when(datasource.createAnnotation(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          final createdAnnotation =
              await repository.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationModel>());
          when(datasource.updateAnnotation(any, any, any)).thenReturn(null);
          when(datasource.getAnnotationById(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          await repository.updateAnnotation(
              "operatorId", createdAnnotation?.annotationId, createdAnnotation);
          final updatedAnnotation = await repository.getAnnotationById(
              "operatorId", createdAnnotation?.annotationId);
          expect(updatedAnnotation, isA<AnnotationModel>());
          expect(updatedAnnotation?.annotationReminder, equals(null));
          expect(updatedAnnotation?.annotationConcluied, equals(equals(false)));
        },
      );
      test(
        "Fail update properties",
        () async {
          when(datasource.createAnnotation(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          final createdAnnotation =
              await repository.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationModel>());
          when(datasource.updateAnnotation(any, any, any)).thenReturn(null);
          when(datasource.getAnnotationById(any, any))
              .thenAnswer((_) async => databaseAnnotationWithNullValue);
          await repository.updateAnnotation("operatorId",
              createdAnnotation?.annotationId, modifiedAnnotation);
          final updatedAnnotation = await repository.getAnnotationById(
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
          when(datasource.createAnnotation(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          when(datasource.getAnnotationById(any, any))
              .thenAnswer((_) async => finishedAnnotation);
          final createdAnnotation =
              await repository.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationModel>());
          when(datasource.finishAnnotation(any, any)).thenReturn(null);
          await repository.finishAnnotation(
              "operatorId", createdAnnotation?.annotationId);
          final repositoryFinishedAnnotation = await repository
              .getAnnotationById("operatorId", createdAnnotation?.annotationId);
          expect(
              repositoryFinishedAnnotation?.annotationConcluied, equals(true));
        },
      );
      test(
        "Fail Finishing the annotation",
        () async {
          when(datasource.createAnnotation(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          when(datasource.getAnnotationById(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          final createdAnnotation =
              await repository.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationModel>());
          when(datasource.finishAnnotation(any, any)).thenReturn(null);
          await repository.finishAnnotation(
              "", createdAnnotation?.annotationId);
          final repositoryFinishedAnnotation = await repository
              .getAnnotationById("operatorId", createdAnnotation?.annotationId);
          expect(
              repositoryFinishedAnnotation?.annotationConcluied, equals(false));
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
          when(datasource.createAnnotation(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          when(datasource.getAllAnnotations(any))
              .thenAnswer((_) async => [databaseAnnotation]);
          final createdAnnotation =
              await repository.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationModel>());
          final annotationsList =
              await repository.getAllAnnotations("operatorId");
          expect(annotationsList, isA<List<AnnotationModel>>());
          expect(annotationsList?.isNotEmpty, equals(true));
          when(datasource.deleteAnnotation(any, any)).thenReturn(null);
          await repository.deleteAnnotation(
              "operatorId", createdAnnotation?.annotationId);
          when(datasource.getAllAnnotations(any)).thenAnswer((_) async => []);
          final currentAnnotationsList =
              await repository.getAllAnnotations("operatorId");
          expect(currentAnnotationsList?.isEmpty, equals(true));
        },
      );
      test(
        "Fail removing annotation",
        () async {
          when(datasource.createAnnotation(any, any))
              .thenAnswer((_) async => databaseAnnotation);
          when(datasource.getAllAnnotations(any))
              .thenAnswer((_) async => [databaseAnnotation]);
          final createdAnnotation =
              await repository.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationModel>());
          final annotationsList =
              await repository.getAllAnnotations("operatorId");
          expect(annotationsList, isA<List<AnnotationModel>>());
          expect(annotationsList?.isNotEmpty, equals(true));
          when(datasource.deleteAnnotation(any, any)).thenReturn(null);
          await repository.deleteAnnotation("operatorId", "");
          when(datasource.getAllAnnotations(any))
              .thenAnswer((_) async => [databaseAnnotation]);
          final currentAnnotationsList =
              await repository.getAllAnnotations("operatorId");
          expect(currentAnnotationsList?.isEmpty, equals(false));
        },
      );
    },
  );
}

final databaseAnnotation = <String, dynamic>{
  'annotationId': "askjdfhlakjsdhkajshdgkjahlskjdghla",
  'annotationClientAddress': "Andorinhas 381",
  'annotationSaleValue': "125,56",
  'annotationSaleTime': "12:45",
  'annotationSaleDate': "07/04",
  'annotationPaymentMethod': "Dinheiro",
  'annotationReminder': null,
  'annotationConcluied': false,
};
final finishedAnnotation = <String, dynamic>{
  'annotationId': "askjdfhlakjsdhkajshdgkjahlskjdghla",
  'annotationClientAddress': "Andorinhas 381",
  'annotationSaleValue': "125,56",
  'annotationSaleTime': "12:45",
  'annotationSaleDate': "07/04",
  'annotationPaymentMethod': "Dinheiro",
  'annotationReminder': null,
  'annotationConcluied': true,
};
final databaseAnnotationWithNullValue = <String, dynamic>{
  'annotationId': "askjdfhlakjsdhkajshdgkjahlskjdghla",
  'annotationClientAddress': "Andorinhas 381",
  'annotationSaleValue': "125,56",
  'annotationSaleTime': "12:45",
  'annotationSaleDate': "07/04",
  'annotationPaymentMethod': null,
  'annotationReminder': "Reminder",
  'annotationConcluied': false,
};
final modifiedDatabaseAnnotation = <String, dynamic>{
  'annotationId': "askjdfhlakjsdhkajshdgkjahlskjdghla",
  'annotationClientAddress': "Andorinhas 381",
  'annotationSaleValue': "125,56",
  'annotationSaleTime': "12:45",
  'annotationSaleDate': "07/04",
  'annotationPaymentMethod': "Cartao",
  'annotationReminder': "Reminder",
  'annotationConcluied': true,
};
