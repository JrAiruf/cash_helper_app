import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/annotations_module/external/annotations_database.dart';
import 'package:cash_helper_app/app/modules/annotations_module/external/data/application_annotations_database.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/models/annotation_model.dart';
import 'package:cash_helper_app/app/utils/tests/annotations_test_objects/test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class AnnotationsDatabaseMock extends Mock implements AnnotationsDatabase {}

class AnnotationsRepositoryMock implements AnnotationRepository {
  AnnotationsRepositoryMock(
      {required ApplicationAnnotationDatabase datasource,
      required DataVerifier dataVerifier})
      : _datasource = datasource,
        _dataVerifier = dataVerifier;
  final ApplicationAnnotationDatabase _datasource;
  final DataVerifier _dataVerifier;
  @override
  Future<AnnotationModel?>? createAnnotation(String? enterpriseId,
      String? operatorId, AnnotationModel? annotation) async {
    if (_dataVerifier.validateInputData(inputs: [enterpriseId, operatorId]) &&
        _dataVerifier.objectVerifier(object: annotation!.toMap())) {
      final datasourceAnnotation = await _datasource.createAnnotation(
          enterpriseId!, operatorId!, annotation.toMap());
      return AnnotationModel.fromMap(datasourceAnnotation!);
    } else {
      return null;
    }
  }

  @override
  Future<AnnotationModel?>? getAnnotationById(
      String? enterpriseId, String? operatorId, String? annotationId) async {
    if (enterpriseId!.isNotEmpty &&
        operatorId!.isNotEmpty &&
        annotationId!.isNotEmpty) {
      final datasourceAnnotation = await _datasource.getAnnotationById(
          enterpriseId, operatorId, annotationId);
      return AnnotationModel.fromMap(datasourceAnnotation ?? {});
    } else {
      return null;
    }
  }

  @override
  Future<List<AnnotationModel>?>? getAllAnnotations(
      String? enterpriseId, String? operatorId) async {
    final datasoourceAnnotationsList =
        await _datasource.getAllAnnotations(enterpriseId!, operatorId!);
    if (enterpriseId.isNotEmpty && operatorId.isNotEmpty) {
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
        .searchAnnotationsByClientAddress(operatorId!, clientAddress!);
    if (operatorId.isNotEmpty && clientAddress.isNotEmpty) {
      final repositorySugestedAnnotations = datasourceSugestedMaps
          ?.map((annotationMap) => AnnotationModel.fromMap(annotationMap))
          .toList();
      return repositorySugestedAnnotations;
    } else {
      return [];
    }
  }

  @override
  Future<void>? updateAnnotation(String? enterpriseId, String? operatorId,
      String? annotationId, AnnotationModel? annotation) async {
    if (annotationId!.isNotEmpty &&
        !annotation!.toMap().values.contains(null)) {
      await _datasource.updateAnnotation(
          operatorId!, annotationId, annotation.toMap());
    } else {
      return;
    }
  }

  @override
  Future<void>? finishAnnotation(
      String? enterpriseId, String? operatorId, String? annotationId) async {
    if (enterpriseId!.isNotEmpty &&
        operatorId!.isNotEmpty &&
        annotationId!.isNotEmpty) {
      await _datasource.finishAnnotation(
          enterpriseId, operatorId, annotationId);
    } else {
      return;
    }
  }

  @override
  Future<void>? deleteAnnotation(
      String? enterpriseId, String? operatorId, String? annotationId) async {
    if (enterpriseId!.isNotEmpty &&
        operatorId!.isNotEmpty &&
        annotationId!.isNotEmpty) {
      await _datasource.deleteAnnotation(
          enterpriseId, operatorId, annotationId);
    } else {
      return;
    }
  }
}

void main() {
  final datasource = AnnotationsDatabaseMock();
  final repository = AnnotationsRepositoryMock(
      datasource: datasource, dataVerifier: DataVerifier());

  group(
    "CreateAnnotation Function Should",
    () {
      test(
        "Call database to create an annotation and return an AnnotationModel object",
        () async {
          when(datasource.createAnnotation(any, any, any)).thenAnswer(
              (_) async => AnnotationsTestObjects.databaseAnnotation);
          final createdAnnotation = await repository.createAnnotation(
              "enterpriseId",
              "operatorId",
              AnnotationsTestObjects.newAnnotationModel);
          expect(createdAnnotation, isA<AnnotationModel>());
          expect(createdAnnotation?.annotationId != null, equals(true));
        },
      );
      test(
        "Fail creating an annotation and returning an AnnotationModel object(returns Null)",
        () async {
          when(datasource.createAnnotation(any, any, any)).thenAnswer(
              (_) async => AnnotationsTestObjects.databaseAnnotation);
          final createdAnnotation = await repository.createAnnotation(
              "", "", AnnotationsTestObjects.newAnnotationModel);
          expect(createdAnnotation == null, equals(true));
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
          when(datasource.getAllAnnotations(any, any)).thenAnswer((_) async => [
                AnnotationsTestObjects.databaseAnnotation,
              ]);
          final annotationsList =
              await repository.getAllAnnotations("enterpriseId", "operatorId");
          expect(annotationsList, isA<List<AnnotationModel>>());
          expect(annotationsList?.isNotEmpty, equals(true));
        },
      );
      test(
        "Fail returning a List<AnnotationModel>(returns [])",
        () async {
          when(datasource.getAllAnnotations(any, any)).thenAnswer((_) async => [
                AnnotationsTestObjects.databaseAnnotation,
              ]);
          final annotationsList = await repository.getAllAnnotations("", "");
          expect(annotationsList?.isNotEmpty, equals(false));
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
          when(datasource.getAnnotationById(any, any, any)).thenAnswer(
              (_) async => AnnotationsTestObjects.databaseAnnotation);
          final obtainedAnnotation = await repository.getAnnotationById(
              "enterpriseId", "operatorId", "annotationId");
          expect(
              obtainedAnnotation?.annotationPaymentMethod, equals("Dinheiro"));
          expect(obtainedAnnotation?.annotationConcluied, equals(false));
        },
      );
      test(
        "Fail returning AnnotationModel object from datasource",
        () async {
          when(datasource.createAnnotation(any, any, any)).thenAnswer(
              (_) async => AnnotationsTestObjects.databaseAnnotation);
          final createdAnnotation = await repository.createAnnotation(
              "enterpriseId",
              "operatorId",
              AnnotationsTestObjects.newAnnotationModel);
          expect(createdAnnotation, isA<AnnotationModel>());
          expect(createdAnnotation?.annotationId != null, equals(true));
          when(datasource.getAnnotationById(any, any, any)).thenAnswer(
              (_) async => AnnotationsTestObjects.databaseAnnotation);
          final obtainedAnnotation = await repository.getAnnotationById(
              "", "", createdAnnotation?.annotationId);
          expect(obtainedAnnotation, equals(null));
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
          when(datasource.createAnnotation(any, any, any)).thenAnswer(
              (realInvocation) async =>
                  AnnotationsTestObjects.databaseAnnotation);
          final createdAnnotation = await repository.createAnnotation(
              "enterpriseId",
              "operatorId",
              AnnotationsTestObjects.newAnnotationModel);
          expect(createdAnnotation, isA<AnnotationModel>());
          when(datasource.finishAnnotation(any, any, any)).thenReturn(null);
          await repository.finishAnnotation(
              "enterpriseId", "operatorId", createdAnnotation?.annotationId);
          when(datasource.getAnnotationById(any, any, any)).thenAnswer(
              (_) async => AnnotationsTestObjects.finishedAnnotation);
          final repositoryFinishedAnnotation =
              await repository.getAnnotationById("enterpriseId", "operatorId",
                  createdAnnotation?.annotationId);
          expect(
              repositoryFinishedAnnotation?.annotationConcluied, equals(true));
        },
      );
      test(
        "Fail Finishing the annotation",
        () async {
          when(datasource.createAnnotation(any, any, any)).thenAnswer(
              (realInvocation) async =>
                  AnnotationsTestObjects.databaseAnnotation);
          final createdAnnotation = await repository.createAnnotation(
              "enterpriseId",
              "operatorId",
              AnnotationsTestObjects.newAnnotationModel);
          expect(createdAnnotation, isA<AnnotationModel>());
          when(datasource.finishAnnotation(any, any, any)).thenReturn(null);
          await repository.finishAnnotation(
              "", "", createdAnnotation?.annotationId);
          when(datasource.getAnnotationById(any, any, any)).thenAnswer(
              (_) async => AnnotationsTestObjects.databaseAnnotation);
          final repositoryFinishedAnnotation =
              await repository.getAnnotationById("enterpriseId", "operatorId",
                  createdAnnotation?.annotationId);
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
          when(datasource.createAnnotation(any, any, any)).thenAnswer(
              (realInvocation) async =>
                  AnnotationsTestObjects.databaseAnnotation);
          final createdAnnotation = await repository.createAnnotation(
              "enterpriseId",
              "operatorId",
              AnnotationsTestObjects.newAnnotationModel);
          when(datasource.deleteAnnotation(any, any, any)).thenReturn(null);
          await repository.deleteAnnotation(
              "enterpriseId", "operatorId", createdAnnotation?.annotationId);
          when(datasource.getAnnotationById(any, any, any))
              .thenAnswer((realInvocation) async => null);
          final repositoryFinishedAnnotation =
              await repository.getAnnotationById("enterpriseId", "operatorId",
                  createdAnnotation?.annotationId);
          expect(repositoryFinishedAnnotation?.annotationId, equals(null));
        },
      );
      test(
        "Fail removing annotation",
        () async {
           when(datasource.createAnnotation(any, any, any)).thenAnswer(
              (realInvocation) async =>
                  AnnotationsTestObjects.databaseAnnotation);
          final createdAnnotation = await repository.createAnnotation(
              "enterpriseId",
              "operatorId",
              AnnotationsTestObjects.newAnnotationModel);
          when(datasource.deleteAnnotation(any, any, any)).thenReturn(null);
          await repository.deleteAnnotation(
              "enterpriseId", "", createdAnnotation?.annotationId);
          when(datasource.getAnnotationById(any, any, any))
              .thenAnswer((realInvocation) async => AnnotationsTestObjects.databaseAnnotation);
          final repositoryFinishedAnnotation =
              await repository.getAnnotationById("enterpriseId", "operatorId",
                  createdAnnotation?.annotationId);
           expect(repositoryFinishedAnnotation, isA<AnnotationModel>());
          expect(repositoryFinishedAnnotation?.annotationId != null, equals(true));
        },
      );
    },
  );
  /*
 
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
   */
}

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
