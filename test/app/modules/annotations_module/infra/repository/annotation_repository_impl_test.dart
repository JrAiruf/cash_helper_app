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
  AnnotationsRepositoryMock({required ApplicationAnnotationDatabase datasource, required DataVerifier dataVerifier})
      : _datasource = datasource,
        _dataVerifier = dataVerifier;
  final ApplicationAnnotationDatabase _datasource;
  final DataVerifier _dataVerifier;
  @override
  Future<AnnotationModel?>? createAnnotation(String? enterpriseId, AnnotationModel? annotation) async {
    if (_dataVerifier.validateInputData(inputs: [enterpriseId]) && _dataVerifier.objectVerifier(object: annotation!.toMap())) {
      final datasourceAnnotation = await _datasource.createAnnotation(enterpriseId!, annotation.toMap());
      return AnnotationModel.fromMap(datasourceAnnotation!);
    } else {
      return null;
    }
  }

  @override
  Future<AnnotationModel?>? createPendingAnnotation(String? enterpriseId, AnnotationModel? annotation) async {
    if (annotation!.toMap().isNotEmpty && enterpriseId!.isNotEmpty) {
      final datasourcePendingAnnotation = await _datasource.createPendingAnnotation(enterpriseId, annotation.toMap()) ?? {};
      return AnnotationModel.fromMap(datasourcePendingAnnotation);
    } else {
      return null;
    }
  }

  @override
  Future<AnnotationModel?>? getAnnotationById(String? enterpriseId, String? operatorId, String? annotationId) async {
    if (enterpriseId!.isNotEmpty && operatorId!.isNotEmpty && annotationId!.isNotEmpty) {
      final datasourceAnnotation = await _datasource.getAnnotationById(enterpriseId, annotationId);
      return AnnotationModel.fromMap(datasourceAnnotation ?? {});
    } else {
      return null;
    }
  }

  @override
  Future<List<AnnotationModel>?>? getAllAnnotations(String? enterpriseId) async {
    final datasoourceAnnotationsList = await _datasource.getAllAnnotations(enterpriseId!);
    if (enterpriseId.isNotEmpty) {
      final annotationsModelList = datasoourceAnnotationsList?.map((annotationMap) => AnnotationModel.fromMap(annotationMap)).toList();
      return annotationsModelList;
    } else {
      return [];
    }
  }

  @override
  Future<List<AnnotationModel>?>? searchAnnotationsByClientAddress(String? operatorId, String? clientAddress) async {
    final datasourceSugestedMaps = await _datasource.searchAnnotationsByClientAddress(operatorId!, clientAddress!);
    if (operatorId.isNotEmpty && clientAddress.isNotEmpty) {
      final repositorySugestedAnnotations = datasourceSugestedMaps?.map((annotationMap) => AnnotationModel.fromMap(annotationMap)).toList();
      return repositorySugestedAnnotations;
    } else {
      return [];
    }
  }

  @override
  Future<void>? updateAnnotation(String? enterpriseId, AnnotationModel? annotation) async {
    if (!annotation!.toMap().values.contains(null)) {
      await _datasource.updateAnnotation(enterpriseId!, annotation.toMap());
    } else {
      return;
    }
  }

  @override
  Future<void>? finishAnnotation(String? enterpriseId, String? operatorId, String? annotationId) async {
    if (enterpriseId!.isNotEmpty && operatorId!.isNotEmpty && annotationId!.isNotEmpty) {
      await _datasource.finishAnnotation(enterpriseId, operatorId, annotationId);
    } else {
      return;
    }
  }

  @override
  Future<void>? deleteAnnotation(String? enterpriseId, String? operatorId, String? annotationId) async {
    if (enterpriseId!.isNotEmpty && operatorId!.isNotEmpty && annotationId!.isNotEmpty) {
      await _datasource.deleteAnnotation(enterpriseId, operatorId, annotationId);
    } else {
      return;
    }
  }

  @override
  Future<List<AnnotationModel>?>? getAllPendingAnnotations(String? enterpriseId) async {
    final datasoourceAnnotationsList = await _datasource.getAllPendingAnnotations(enterpriseId!);
    if (enterpriseId.isNotEmpty) {
      final annotationsModelList = datasoourceAnnotationsList?.map((annotationMap) => AnnotationModel.fromMap(annotationMap)).toList();
      return annotationsModelList;
    } else {
      return [];
    }
  }
}

void main() {
  late AnnotationsDatabaseMock datasource;
  late AnnotationsRepositoryMock repository;
  setUp(
    () {
      datasource = AnnotationsDatabaseMock();
      repository = AnnotationsRepositoryMock(datasource: datasource, dataVerifier: DataVerifier());
    },
  );

  group(
    "CreateAnnotation Function Should",
    () {
      test(
        "Call database to create an annotation and return an AnnotationModel object",
        () async {
          when(datasource.createAnnotation(any, any)).thenAnswer((_) async => AnnotationsTestObjects.databaseAnnotation);
          final createdAnnotation = await repository.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationModel);
          expect(createdAnnotation, isA<AnnotationModel>());
          expect(createdAnnotation?.annotationId != null, equals(true));
        },
      );
      test(
        "Fail creating an annotation and returning an AnnotationModel object(returns Null)",
        () async {
          when(datasource.createAnnotation(any, any)).thenAnswer((_) async => AnnotationsTestObjects.databaseAnnotation);
          final createdAnnotation = await repository.createAnnotation("", AnnotationsTestObjects.newAnnotationModel);
          expect(createdAnnotation == null, equals(true));
        },
      );
    },
  );
  group(
    "CreatePendingAnnotation Function Should",
    () {
      test(
        "Call database to create an annotation and return an AnnotationModel object",
        () async {
          when(datasource.createPendingAnnotation(any, any)).thenAnswer((_) async => AnnotationsTestObjects.newPendingAnnotationMap);
          final createdAnnotation = await repository.createPendingAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationModel);
          expect(createdAnnotation, isA<AnnotationModel>());
          expect(createdAnnotation?.annotationId != null, equals(true));
        },
      );
      test(
        "Fail creating an annotation and returning an AnnotationModel object(returns Null)",
        () async {
          when(datasource.createPendingAnnotation(any, any)).thenAnswer((_) async => AnnotationsTestObjects.databaseAnnotation);
          final createdAnnotation = await repository.createPendingAnnotation("", AnnotationsTestObjects.newAnnotationModel);
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
          when(datasource.getAllAnnotations(any)).thenAnswer((_) async => [
                AnnotationsTestObjects.databaseAnnotation,
              ]);
          final annotationsList = await repository.getAllAnnotations("enterpriseId");
          expect(annotationsList, isA<List<AnnotationModel>>());
          expect(annotationsList?.isNotEmpty, equals(true));
        },
      );
      test(
        "Fail returning a List<AnnotationModel>(returns [])",
        () async {
          when(datasource.getAllAnnotations(any)).thenAnswer((_) async => [
                AnnotationsTestObjects.databaseAnnotation,
              ]);
          final annotationsList = await repository.getAllAnnotations("");
          expect(annotationsList?.isNotEmpty, equals(false));
        },
      );
    },
  );
  group(
    "GetAllPendingAnnotations Function Should",
    () {
      test(
        "Return a List<AnnotationModel>",
        () async {
          when(datasource.getAllPendingAnnotations(any)).thenAnswer((_) async => [
                AnnotationsTestObjects.databasePendingAnnotation,
              ]);
          final annotationsList = await repository.getAllPendingAnnotations("enterpriseId");
          expect(annotationsList, isA<List<AnnotationModel>>());
          expect(annotationsList?.isNotEmpty, equals(true));
        },
      );
      test(
        "Fail returning a List<AnnotationModel>(returns [])",
        () async {
          when(datasource.getAllAnnotations(any)).thenAnswer((_) async => [
                AnnotationsTestObjects.databaseAnnotation,
              ]);
          final annotationsList = await repository.getAllPendingAnnotations("");
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
          when(datasource.getAnnotationById(any, any)).thenAnswer((_) async => AnnotationsTestObjects.databaseAnnotation);
          final obtainedAnnotation = await repository.getAnnotationById("enterpriseId", "operatorId", "annotationId");
          expect(obtainedAnnotation?.annotationPaymentMethod, equals("Dinheiro"));
          expect(obtainedAnnotation?.annotationConcluied, equals(false));
        },
      );
      test(
        "Fail returning AnnotationModel object from datasource",
        () async {
          when(datasource.createAnnotation(any, any)).thenAnswer((_) async => AnnotationsTestObjects.databaseAnnotation);
          final createdAnnotation = await repository.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationModel);
          expect(createdAnnotation, isA<AnnotationModel>());
          expect(createdAnnotation?.annotationId != null, equals(true));
          when(datasource.getAnnotationById(any, any)).thenAnswer((_) async => AnnotationsTestObjects.databaseAnnotation);
          final obtainedAnnotation = await repository.getAnnotationById("", "", createdAnnotation?.annotationId);
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
          when(datasource.createAnnotation(any, any)).thenAnswer((realInvocation) async => AnnotationsTestObjects.databaseAnnotation);
          final createdAnnotation = await repository.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationModel);
          expect(createdAnnotation, isA<AnnotationModel>());
          when(datasource.finishAnnotation(any, any, any)).thenReturn(null);
          await repository.finishAnnotation("enterpriseId", "operatorId", createdAnnotation?.annotationId);
          when(datasource.getAnnotationById(any, any)).thenAnswer((_) async => AnnotationsTestObjects.finishedAnnotation);
          final repositoryFinishedAnnotation = await repository.getAnnotationById("enterpriseId", "operatorId", createdAnnotation?.annotationId);
          expect(repositoryFinishedAnnotation?.annotationConcluied, equals(true));
        },
      );
      test(
        "Fail Finishing the annotation",
        () async {
          when(datasource.createAnnotation(any, any)).thenAnswer((realInvocation) async => AnnotationsTestObjects.databaseAnnotation);
          final createdAnnotation = await repository.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationModel);
          expect(createdAnnotation, isA<AnnotationModel>());
          when(datasource.finishAnnotation(any, any, any)).thenReturn(null);
          await repository.finishAnnotation("", "", createdAnnotation?.annotationId);
          when(datasource.getAnnotationById(any, any)).thenAnswer((_) async => AnnotationsTestObjects.databaseAnnotation);
          final repositoryFinishedAnnotation = await repository.getAnnotationById("enterpriseId", "operatorId", createdAnnotation?.annotationId);
          expect(repositoryFinishedAnnotation?.annotationConcluied, equals(false));
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
          when(datasource.createAnnotation(any, any)).thenAnswer((realInvocation) async => AnnotationsTestObjects.databaseAnnotation);
          final createdAnnotation = await repository.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationModel);
          when(datasource.deleteAnnotation(any, any, any)).thenReturn(null);
          await repository.deleteAnnotation("enterpriseId", "operatorId", createdAnnotation?.annotationId);
          when(datasource.getAnnotationById(any, any)).thenAnswer((realInvocation) async => null);
          final repositoryFinishedAnnotation = await repository.getAnnotationById("enterpriseId", "operatorId", createdAnnotation?.annotationId);
          expect(repositoryFinishedAnnotation?.annotationId, equals(null));
        },
      );
      test(
        "Fail removing annotation",
        () async {
          when(datasource.createAnnotation(any, any)).thenAnswer((realInvocation) async => AnnotationsTestObjects.databaseAnnotation);
          final createdAnnotation = await repository.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationModel);
          when(datasource.deleteAnnotation(any, any, any)).thenReturn(null);
          await repository.deleteAnnotation("enterpriseId", "", createdAnnotation?.annotationId);
          when(datasource.getAnnotationById(any, any)).thenAnswer((realInvocation) async => AnnotationsTestObjects.databaseAnnotation);
          final repositoryFinishedAnnotation = await repository.getAnnotationById("enterpriseId", "operatorId", createdAnnotation?.annotationId);
          expect(repositoryFinishedAnnotation, isA<AnnotationModel>());
          expect(repositoryFinishedAnnotation?.annotationId != null, equals(true));
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
          when(datasource.createAnnotation(any, any)).thenAnswer((_) async => AnnotationsTestObjects.databaseAnnotation);
          final createdAnnotation = await repository.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationModel);
          expect(createdAnnotation, isA<AnnotationModel>());
          when(datasource.updateAnnotation(any, any)).thenReturn(null);
          when(datasource.getAnnotationById(any, any)).thenAnswer((_) async => AnnotationsTestObjects.databaseAnnotation);
          await repository.updateAnnotation("enterpriseId", createdAnnotation);
          final updatedAnnotation = await repository.getAnnotationById("enterpriseId", "operatorId", createdAnnotation?.annotationId);
          expect(updatedAnnotation, isA<AnnotationModel>());
          expect(updatedAnnotation?.annotationReminder, equals(null));
          expect(updatedAnnotation?.annotationConcluied, equals(equals(false)));
        },
      );
      test(
        "Fail update properties",
        () async {
          when(datasource.createAnnotation(any, any)).thenAnswer((_) async => AnnotationsTestObjects.databaseAnnotation);
          final createdAnnotation = await repository.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationModel);
          expect(createdAnnotation, isA<AnnotationModel>());
          when(datasource.updateAnnotation(any, any)).thenReturn(null);
          when(datasource.getAnnotationById(any, any)).thenAnswer((_) async => AnnotationsTestObjects.newPendingAnnotationMap);
          await repository.updateAnnotation("enterpriseId", AnnotationsTestObjects.modifiedAnnotationModel);
          final updatedAnnotation = await repository.getAnnotationById("enterpriseId", "operatorId", createdAnnotation?.annotationId);
          expect(updatedAnnotation?.annotationReminder, equals(null));
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
  
   */
}
