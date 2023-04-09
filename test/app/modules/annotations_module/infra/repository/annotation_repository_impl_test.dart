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
   final datasoourceAnnotationsList = await _datasource.getAllAnnotations(operatorId);
   if (operatorId!.isNotEmpty) {
     final annotationsModelList = datasoourceAnnotationsList?.map((annotationMap) => AnnotationModel.fromMap(annotationMap)).toList();
     return annotationsModelList;
   } else {
    return [];
   }
  }

  @override
  Future<List<AnnotationModel>?>? searchAnnotationsByClientAddress(
      String? operatorId, String? clientAddress) {
    // TODO: implement searchAnnotationsByClientAddress
    throw UnimplementedError();
  }

  @override
  Future<AnnotationModel?>? updateAnnotation(
      String? operatorId, String? annotationId, AnnotationModel? annotation) {
    // TODO: implement updateAnnotation
    throw UnimplementedError();
  }

  @override
  Future<void>? finishAnnotation(String? operatorId, String? annotationId) {
    // TODO: implement finishAnnotation
    throw UnimplementedError();
  }

  @override
  Future<void>? deleteAnnotation(String? operatorId, String? annotationId) {
    // TODO: implement deleteAnnotation
    throw UnimplementedError();
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
          final annotationsList = await repository.getAllAnnotations("operatorId");
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
        () async {},
      );
      test(
        "Fail returning an annotation from result search",
        () async {},
      );
    },
  );
  group(
    "UpdateAnnotation Function Should",
    () {
      test(
        "Update the respective property passed in object",
        () async {},
      );
      test(
        "Fail update properties",
        () async {},
      );
    },
  );
  group(
    "FinishAnnotation Function Should",
    () {
      test(
        "Change the state of annotation(false to true)",
        () async {},
      );
      test(
        "Fail Finishing the annotation",
        () async {},
      );
    },
  );
  group(
    "DeleteAnnotation Function Should",
    () {
      test(
        "Remove annotation",
        () async {},
      );
      test(
        "Fail removing annotation",
        () async {},
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
final modifiedDatabaseAnnotation = <String, dynamic>{
  'annotationId': "askjdfhlakjsdhkajshdgkjahlskjdghla",
  'annotationClientAddress': "Andorinhas 381",
  'annotationSaleValue': "125,56",
  'annotationSaleTime': "12:45",
  'annotationSaleDate': "07/04",
  'annotationPaymentMethod': "Dinheiro",
  'annotationReminder': null,
  'annotationConcluied': true,
};
