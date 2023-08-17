import 'package:cash_helper_app/app/modules/annotations_module/external/data/application_annotations_database.dart';
import 'package:cash_helper_app/app/utils/tests/annotations_test_objects/test_objects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

class AFirebaseDatabaseMock implements ApplicationAnnotationDatabase {
  AFirebaseDatabaseMock({required FirebaseFirestore database, required this.uuidGenertor}) : _database = database;

  final FirebaseFirestore _database;
  final Uuid uuidGenertor;
  Map<String, dynamic>? annotationData = {};
  @override
  Future<Map<String, dynamic>?>? createAnnotation(String? enterpriseId, Map<String, dynamic>? annotation) async {
    final annotationsCollection = _getCollection(enterpriseId);
    if (enterpriseId != null && annotation != null) {
      annotationData = await _createNewAnnotation(annotationsCollection, enterpriseId, annotation);
      return annotationData!.isEmpty ? null : annotationData;
    } else {
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> createPendingAnnotation(String? enterpriseId, Map<String, dynamic>? annotation) async {
    if (enterpriseId != null && annotation != null) {
      await _createPendingAnnotation(enterpriseId, annotation);
      final currentAnnotation =
          await _database.collection("enterprise").doc(enterpriseId).collection("pendingAnnotations").doc(annotation["annotationId"]).get().then((value) => value.data() ?? <String, dynamic>{});
      return currentAnnotation.isEmpty ? null : currentAnnotation;
    } else {
      return null;
    }
  }

  @override
  Future<List<Map<String, dynamic>>?>? getAllAnnotations(String? enterpriseId) async {
    final annotationsCollection = _database.collection("enterprise").doc(enterpriseId).collection("generalAnnotations");
    if (enterpriseId != null) {
      final annotationsList = await annotationsCollection.get();
      return annotationsList.docs.map((annotation) => annotation.data()).toList();
    } else {
      return null;
    }
  }

  @override
  Future<List<Map<String, dynamic>>?>? getAllPendingAnnotations(String? enterpriseId) async {
    final pendingAnnotationsList = await _database.collection("enterprise").doc(enterpriseId).collection("pendingAnnotations").get();
    final pendingAnnotationsMapList = pendingAnnotationsList.docs.map((e) => e.data()).toList();
    if (pendingAnnotationsMapList.isNotEmpty) {
      return pendingAnnotationsMapList;
    } else {
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?>? getAnnotationById(String? enterpriseId, String? annotationId) async {
    final annotationsCollection = _getCollection(enterpriseId);
    if (enterpriseId != null && annotationId != null) {
      final databaseDocumentsList = await annotationsCollection.get().then((value) => value.docs);
      final annotationsMapsList = databaseDocumentsList.map((annotation) => annotation.data()).toList();
      final matcherAnnotation = annotationsMapsList.firstWhere((annotation) => annotation["annotationId"] == annotationId);
      return matcherAnnotation.isNotEmpty ? matcherAnnotation : null;
    } else {
      return null;
    }
  }

  @override
  Future<List<Map<String, dynamic>>?>? searchAnnotationsByClientAddress(String? operatorId, String? clientAddress) async {
    throw UnimplementedError();
  }

  @override
  Future<void>? finishAnnotation(String? enterpriseId, String? operatorId, String? annotationId) async {
    final annotationsCollection = _getCollection(enterpriseId);
    if (enterpriseId!.isNotEmpty && operatorId!.isNotEmpty && annotationId!.isNotEmpty) {
      await annotationsCollection.doc(annotationId).update({"annotationConcluied": true});
    }
  }

  @override
  Future<void>? updateAnnotation(String? enterpriseId, Map<String, dynamic>? annotation) async {
    final annotationsCollection = _getCollection(enterpriseId);
    try {
      await annotationsCollection.doc(annotation?["annotationId"]).update(annotation!);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void>? deleteAnnotation(String? enterpriseId, String? operatorId, String? annotationId) async {
    final operatorAnnotationsCollection = _getCollection(enterpriseId);
    final generalAnnotationsCollection = _database.collection("enterprise").doc(enterpriseId).collection("generalAnnotations");
    if (enterpriseId!.isNotEmpty && operatorId!.isNotEmpty && annotationId!.isNotEmpty) {
      await operatorAnnotationsCollection.doc(annotationId).delete();
      generalAnnotationsCollection.doc(annotationId).delete();
    }
  }

  CollectionReference<Map<String, dynamic>> _getCollection(String? enterpriseId) => _database.collection("enterprise").doc(enterpriseId).collection("generalAnnotations");

  Future<void> _createPendingAnnotation(String enterpriseId, Map<String, dynamic> annotation) async {
    await _database.collection("enterprise").doc(enterpriseId).collection("pendingAnnotations").doc(annotation["annotationId"]).set(annotation);
  }

  Future<Map<String, dynamic>> _createNewAnnotation(CollectionReference annotationsCollection, String enterpriseId, Map<String, dynamic> annotation) async {
    annotation["annotationId"] = uuidGenertor.v1();
    await annotationsCollection.doc(annotation["annotationId"]).set(annotation);
    final createdAnnotation = await annotationsCollection.doc(annotation["annotationId"]).get().then((value) => value.data()) as Map<String, dynamic>;
    if (createdAnnotation.isNotEmpty) {
      return createdAnnotation;
    } else {
      return {};
    }
  }
}

void main() {
  late FakeFirebaseFirestore firebaseMock;
  late AFirebaseDatabaseMock database;
  setUp(
    () {
      firebaseMock = FakeFirebaseFirestore();
      database = AFirebaseDatabaseMock(database: firebaseMock, uuidGenertor: const Uuid());
    },
  );

  group(
    "CreateAnnotation function should",
    () {
      test(
        "Create an annotation in the current user",
        () async {
          final result = await database.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationMap);
          final generalAnnotationsCollection = await firebaseMock.collection("enterprise").doc("enterpriseId").collection("generalAnnotations").get();
          expect(generalAnnotationsCollection.docs.isNotEmpty, equals(true));
          expect(result, isA<Map<String, dynamic>>());
          expect(result?["annotationId"] != null, equals(true));
        },
      );
      test(
        "Fail Creating annotation",
        () async {
          final createdAnnotation = await database.createAnnotation(null, AnnotationsTestObjects.newAnnotationMap);
          expect(createdAnnotation, equals(null));
        },
      );
    },
  );
  group(
    "CreatePendingAnnotation function should",
    () {
      test(
        "Create a pending annotation in the current user",
        () async {
          final result = await database.createPendingAnnotation("enterpriseId", AnnotationsTestObjects.newPendingAnnotationMap);
          final annotationsCollection = await firebaseMock.collection("enterprise").doc("enterpriseId").collection("pendingAnnotations").get();
          final pendingAnnotation = annotationsCollection.docs.first;
          expect(annotationsCollection.docs.isNotEmpty, equals(true));
          expect(pendingAnnotation["annotationSaleValue"], equals("500,56"));
          expect(result, isA<Map<String, dynamic>>());
          expect(result?["annotationWithPendency"], equals(true));
        },
      );
      test(
        "Fail Creating pending annotation",
        () async {
          final createdAnnotation = await database.createPendingAnnotation(null, AnnotationsTestObjects.newAnnotationMap);
          expect(createdAnnotation, equals(null));
        },
      );
    },
  );
  group(
    "GetAllAnnotations function should",
    () {
      test(
        "Return all annotations created (List<Map<String,dynamic>>)",
        () async {
          final createdAnnotation = await database.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationMap);
          expect(createdAnnotation, isA<Map<String, dynamic>>());
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          final result = await database.getAllAnnotations("enterpriseId");
          expect(result, isA<List<Map<String, dynamic>>>());
          expect(result?.first != null, equals(true));
        },
      );
      test(
        "Fail Returning annotations",
        () async {
          final result = await database.createAnnotation("", AnnotationsTestObjects.newAnnotationMap);
          expect(result, isA<Map<String, dynamic>>());
          expect(result?["annotationId"] != null, equals(true));
          final createdAnnotation = await database.getAllAnnotations(null);
          expect(createdAnnotation, equals(null));
        },
      );
    },
  );
  group(
    "GetAllPendingAnnotations function should",
    () {
      test(
        "Return all pending annotations (List<Map<String,dynamic>>)",
        () async {
          final createdAnnotation = await database.createPendingAnnotation("enterpriseId", AnnotationsTestObjects.newPendingAnnotationMap);
          expect(createdAnnotation, isA<Map<String, dynamic>>());
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          final result = await database.getAllPendingAnnotations("enterpriseId");
          expect(result, isA<List<Map<String, dynamic>>>());
          expect(result?.first != null, equals(true));
        },
      );
      test(
        "Fail Returning pending annotations",
        () async {
          final createdAnnotation = await database.createPendingAnnotation("enterpriseId", AnnotationsTestObjects.newPendingAnnotationMap);
          expect(createdAnnotation, isA<Map<String, dynamic>>());
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          final pendingAnnotationsList = await database.getAllPendingAnnotations(null);
          expect(pendingAnnotationsList, equals(null));
        },
      );
    },
  );
  group(
    "GetAnnotationById function should",
    () {
      test(
        "Return the annotation which the id property matches annotationId parameter(Map<String,dynamic>)",
        () async {
          final createdAnnotation = await database.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationMap);
          expect(createdAnnotation, isA<Map<String, dynamic>>());
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          final currentAnnotation = await database.getAnnotationById("enterpriseId", createdAnnotation?["annotationId"]);
          expect(currentAnnotation, isA<Map<String, dynamic>>());
          expect(currentAnnotation?.isNotEmpty, equals(true));
        },
      );
      test(
        "Fail Returning the annotation by it's id",
        () async {
          final result = await database.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationMap);
          expect(result, isA<Map<String, dynamic>>());
          expect(result?["annotationId"] != null, equals(true));
          final currentAnnotation = await database.getAnnotationById("", null);
          expect(currentAnnotation, equals(null));
        },
      );
    },
  );
  group(
    "FinishAnnotation function should",
    () {
      test(
        "Change annotationConcluied property to true, setting it in database",
        () async {
          final createdAnnotation = await database.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationMap);
          expect(createdAnnotation, isA<Map<String, dynamic>>());
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          await database.finishAnnotation("enterpriseId", "operatorId", createdAnnotation?["annotationId"]);
          final currentAnnotation = await database.getAnnotationById("enterpriseId", createdAnnotation?["annotationId"]);
          expect(currentAnnotation?["annotationConcluied"], equals(true));
        },
      );
      test(
        "Fail finishing annotation",
        () async {
          final createdAnnotation = await database.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationMap);
          expect(createdAnnotation, isA<Map<String, dynamic>>());
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          await database.finishAnnotation("", "", null);
          final currentAnnotation = await database.getAnnotationById("enterpriseId", createdAnnotation?["annotationId"]);
          expect(currentAnnotation?["annotationConcluied"], equals(false));
        },
      );
    },
  );
  group(
    "DeleteAnnotation function should",
    () {
      test(
        "Delete annotation in database",
        () async {
          final createdAnnotation = await database.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationMap);
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          final annotationsList = await database.getAllAnnotations("enterpriseId");
          expect(annotationsList?.isNotEmpty, equals(true));
          await database.deleteAnnotation("enterpriseId", "operatorId", createdAnnotation?["annotationId"]);
          final currentAnnotationsList = await database.getAllAnnotations("enterpriseId");
          expect(currentAnnotationsList?.isEmpty, equals(true));
        },
      );
      test(
        "Fail deleting the annotation",
        () async {
          final createdAnnotation = await database.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationMap);
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          final annotationsList = await database.getAllAnnotations("enterpriseId");
          expect(annotationsList?.isNotEmpty, equals(true));
          await database.deleteAnnotation("enterpriseId", "operatorId", "");
          final currentAnnotationsList = await database.getAllAnnotations("enterpriseId");
          expect(currentAnnotationsList?.isEmpty, equals(false));
        },
      );
    },
  );

  group(
    "UpdateAnnotation function should",
    () {
      test(
        "Change properties passed inside map object, updating the annotation in database",
        () async {
          final createdAnnotation = await database.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationMap);
          expect(createdAnnotation, isA<Map<String, dynamic>>());
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          expect(createdAnnotation?["annotationSaleValue"], equals("125,56"));
          createdAnnotation?["annotationConcluied"] = true;
          await database.updateAnnotation("enterpriseId", createdAnnotation);
          final currentAnnotation = await database.getAnnotationById("enterpriseId", createdAnnotation?["annotationId"]);
          expect(currentAnnotation?["annotationSaleValue"], equals("125,56"));
          expect(currentAnnotation?["annotationPaymentMethod"], equals("Dinheiro"));
          expect(createdAnnotation?["annotationConcluied"], equals(true));
        },
      );
      test(
        "Fail updating the annotation",
        () async {
          final createdAnnotation = await database.createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotationMap);
          expect(createdAnnotation, isA<Map<String, dynamic>>());
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          expect(createdAnnotation?["annotationSaleValue"], equals("125,56"));
          await database.updateAnnotation("enterpriseId", {});
          final currentAnnotation = await database.getAnnotationById("enterpriseId", createdAnnotation?["annotationId"]);
          expect(currentAnnotation?["annotationSaleValue"], equals("125,56"));
          expect(currentAnnotation?["annotationPaymentMethod"], equals("Dinheiro"));
        },
      );
    },
  );
  /*
  
  group(
    "SearchAnnotationsByClientAddress function should",
    () {
      test(
        "Return the annotations which the annotationClientAddress property matches clientAddress parameter(List<Map<String, dynamic>>)",
        () async {
          final createdAnnotation =
              await database.createAnnotation newAnnotation);
          expect(createdAnnotation, isA<Map<String, dynamic>>());
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          final currentAnnotations =
              await database.searchAnnotationsByClientAddress(
                 createdAnnotation?["annotationClientAddress"]);
          expect(currentAnnotations, isA<List<Map<String, dynamic>>>());
          expect(currentAnnotations?.isNotEmpty, equals(true));
        },
      );
      test(
        "Fail Returning the annotation by client address",
        () async {
          final result =
              await database.createAnnotation newAnnotation);
          expect(result, isA<Map<String, dynamic>>());
          expect(result?["annotationId"] != null, equals(true));
          final currentAnnotation =
              await database.getAnnotationById null);
          expect(currentAnnotation, equals(null));
        },
      );
    },
  );
  
  
 */
}
