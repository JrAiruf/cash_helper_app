import 'package:cash_helper_app/app/modules/annotations_module/external/data/application_annotations_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

class AFirebaseDatabaseMock implements ApplicationAnnotationDatabase {
  AFirebaseDatabaseMock(
      {required FirebaseFirestore database, required this.uuidGenertor})
      : _database = database;

  final FirebaseFirestore _database;
  final Uuid uuidGenertor;
  Map<String, dynamic>? annotationData = {};
  @override
  Future<Map<String, dynamic>?>? createAnnotation(
      String? operatorId, Map<String, dynamic>? annotation) async {
    final annotationsCollection = _database
        .collection("operators")
        .doc(operatorId)
        .collection("annotations");
    if (operatorId != null && annotation != null && annotation.isNotEmpty) {
      annotation["annotationId"] = uuidGenertor.v1();
      await annotationsCollection
          .doc(annotation["annotationId"])
          .set(annotation);
      final createdAnnotation = await annotationsCollection
          .doc(annotation["annotationId"])
          .get()
          .then((value) => value.data());
      annotationData = createdAnnotation ?? {};
      return annotationData!.isEmpty ? null : annotationData;
    } else {
      return null;
    }
  }

  @override
  Future<List<Map<String, dynamic>>?>? getAllAnnotations(
      String? operatorId) async {
    final annotationsCollection = _database
        .collection("operators")
        .doc(operatorId)
        .collection("annotations");
    if (operatorId != null) {
      final annotationsList = await annotationsCollection.get();
      return annotationsList.docs
          .map((annotation) => annotation.data())
          .toList();
    } else {
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?>? getAnnotationById(
      String? operatorId, String? annotationId) async {
    final annotationsCollection = _database
        .collection("operators")
        .doc(operatorId)
        .collection("annotations");
    if (operatorId != null && annotationId != null) {
      final databaseDocumentsList =
          await annotationsCollection.get().then((value) => value.docs);
      final annotationsMapsList =
          databaseDocumentsList.map((annotation) => annotation.data()).toList();
      final matcherAnnotation = annotationsMapsList.firstWhere(
          (annotation) => annotation["annotationId"] == annotationId);
      return matcherAnnotation.isNotEmpty ? matcherAnnotation : null;
    } else {
      return null;
    }
  }

  @override
  Future<List<Map<String, dynamic>>?>? searchAnnotationsByClientAddress(
      String? operatorId, String? clientAddress) async {
    if (operatorId != null && clientAddress != null) {
      final databaseSuggestedAnnotationsList = await _filterSearchClientAddress(
          operatorId: operatorId, clientAddress: clientAddress);
      final suggestedAnnotationsList = databaseSuggestedAnnotationsList
          .map((annotation) => annotation.data())
          .toList();
      return suggestedAnnotationsList.isNotEmpty
          ? suggestedAnnotationsList
          : null;
    } else {
      return null;
    }
  }

  @override
  Future<void>? finishAnnotation(
      String? operatorId, String? annotationId) async {
    if (operatorId != null && annotationId != null) {
      final annotationsCollection = _getCollection(operatorId);
      await annotationsCollection
          .doc(annotationId)
          .update({"annotationConcluied": true});
    } else {
      return;
    }
  }

  @override
  Future<void>? updateAnnotation(String? operatorId, String? annotationId,
      Map<String, dynamic>? annotation) async {
    if (operatorId != null && annotationId != null && annotation != null) {
      final annotationsCollection = _getCollection(operatorId);
      await annotationsCollection.doc(annotationId).update(annotation);
    }
  }

  @override
  Future<void>? deleteAnnotation(
      String? operatorId, String? annotationId) async {
    if (operatorId != null && annotationId != null) {
      final annotationsCollection = _getCollection(operatorId);
      await annotationsCollection.doc(annotationId).delete();
    } else {
      return;
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _filterSearchClientAddress(
          {required String operatorId, required String clientAddress}) async {
    final dividedSearchText = clientAddress.split(' ');
    final simpleSearchText = dividedSearchText[0];
    final databaseAnnotationsCollection =
        await _getCollection(operatorId).get();
    final databaseSearchList =
        databaseAnnotationsCollection.docs.where((annotation) {
      final clientAddress =
          annotation.data()["annotationClientAddress"] as String;
      final splitedClientAddress = clientAddress.contains(simpleSearchText);
      return splitedClientAddress;
    }).toList();
    return databaseSearchList;
  }

  CollectionReference<Map<String, dynamic>> _getCollection(
          String? operatorId) =>
      _database
          .collection("operators")
          .doc(operatorId)
          .collection("annotations");
}

void main() {
  final newAnnotation = <String, dynamic>{
    'annotationId': "askjdfhlakjsdhkajshdgkjahlskjdghla",
    'annotationClientAddress': "Andorinhas 381",
    'annotationSaleValue': "125,56",
    'annotationSaleTime': "12:45",
    'annotationSaleDate': "07/04",
    'annotationPaymentMethod': "Dinheiro",
    'annotationReminder': null,
    'annotationConcluied': false,
  };
  final updatedAnnotation = <String, dynamic>{
    'annotationClientAddress': "Andorinhas 381",
    'annotationSaleValue': "300",
    'annotationSaleTime': "12:45",
    'annotationSaleDate': "07/04",
    'annotationPaymentMethod': "Crédito",
    'annotationReminder': "Reminder added",
    'annotationConcluied': false,
  };
  final firebaseMock = FakeFirebaseFirestore();
  const uuid = Uuid();
  final database =
      AFirebaseDatabaseMock(database: firebaseMock, uuidGenertor: uuid);

  group(
    "Create function should",
    () {
      test(
        "Create an annotation in the current user",
        () async {
          final result =
              await database.createAnnotation("operatorId", newAnnotation);
          expect(result, isA<Map<String, dynamic>>());
          expect(result?["annotationId"] != null, equals(true));
        },
      );
      test(
        "Fail Creating annotation",
        () async {
          final createdAnnotation =
              await database.createAnnotation(null, newAnnotation);
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
          final createdAnnotation =
              await database.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<Map<String, dynamic>>());
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          final result = await database.getAllAnnotations("operatorId");
          expect(result, isA<List<Map<String, dynamic>>>());
          expect(result?.first != null, equals(true));
        },
      );
      test(
        "Fail Returning annotations",
        () async {
          final result =
              await database.createAnnotation("operatorId", newAnnotation);
          expect(result, isA<Map<String, dynamic>>());
          expect(result?["annotationId"] != null, equals(true));
          final createdAnnotation = await database.getAllAnnotations(null);
          expect(createdAnnotation, equals(null));
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
          final createdAnnotation =
              await database.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<Map<String, dynamic>>());
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          final currentAnnotation = await database.getAnnotationById(
              "operatorId", createdAnnotation?["annotationId"]);
          expect(currentAnnotation, isA<Map<String, dynamic>>());
          expect(currentAnnotation?.isNotEmpty, equals(true));
        },
      );
      test(
        "Fail Returning the annotation by it's id",
        () async {
          final result =
              await database.createAnnotation("operatorId", newAnnotation);
          expect(result, isA<Map<String, dynamic>>());
          expect(result?["annotationId"] != null, equals(true));
          final currentAnnotation =
              await database.getAnnotationById("operatorId", null);
          expect(currentAnnotation, equals(null));
        },
      );
    },
  );
  group(
    "SearchAnnotationsByClientAddress function should",
    () {
      test(
        "Return the annotations which the annotationClientAddress property matches clientAddress parameter(List<Map<String, dynamic>>)",
        () async {
          final createdAnnotation =
              await database.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<Map<String, dynamic>>());
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          final currentAnnotations =
              await database.searchAnnotationsByClientAddress(
                  "operatorId", createdAnnotation?["annotationClientAddress"]);
          expect(currentAnnotations, isA<List<Map<String, dynamic>>>());
          expect(currentAnnotations?.isNotEmpty, equals(true));
        },
      );
      test(
        "Fail Returning the annotation by client address",
        () async {
          final result =
              await database.createAnnotation("operatorId", newAnnotation);
          expect(result, isA<Map<String, dynamic>>());
          expect(result?["annotationId"] != null, equals(true));
          final currentAnnotation =
              await database.getAnnotationById("operatorId", null);
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
          final createdAnnotation =
              await database.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<Map<String, dynamic>>());
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          await database.finishAnnotation(
              "operatorId", createdAnnotation?["annotationId"]);
          final currentAnnotation = await database.getAnnotationById(
              "operatorId", createdAnnotation?["annotationId"]);
          expect(currentAnnotation?["annotationConcluied"], equals(true));
        },
      );
      test(
        "Fail finishing annotation",
        () async {
          final createdAnnotation =
              await database.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<Map<String, dynamic>>());
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          await database.finishAnnotation("operatorId", null);
          final currentAnnotation = await database.getAnnotationById(
              "operatorId", createdAnnotation?["annotationId"]);
          expect(currentAnnotation?["annotationConcluied"], equals(false));
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
          final createdAnnotation =
              await database.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<Map<String, dynamic>>());
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          expect(createdAnnotation?["annotationSaleValue"], equals("125,56"));
          await database.updateAnnotation("operatorId",
              createdAnnotation?["annotationId"], updatedAnnotation);
          final currentAnnotation = await database.getAnnotationById(
              "operatorId", createdAnnotation?["annotationId"]);
          expect(currentAnnotation?["annotationSaleValue"], equals("300"));
          expect(
              currentAnnotation?["annotationPaymentMethod"], equals("Crédito"));
        },
      );
      test(
        "Fail updating the annotation",
        () async {
          final createdAnnotation =
              await database.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<Map<String, dynamic>>());
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          expect(createdAnnotation?["annotationSaleValue"], equals("125,56"));
          await database.updateAnnotation(
              "operatorId", createdAnnotation?["annotationId"], null);
          final currentAnnotation = await database.getAnnotationById(
              "operatorId", createdAnnotation?["annotationId"]);
          expect(currentAnnotation?["annotationSaleValue"], equals("125,56"));
          expect(currentAnnotation?["annotationPaymentMethod"],
              equals("Dinheiro"));
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
          final createdAnnotation =
              await database.createAnnotation("anotherId", newAnnotation);
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          final annotationsList =
              await database.getAllAnnotations("anotherId");
          expect(annotationsList?.isNotEmpty, equals(true));
          await database.deleteAnnotation(
              "anotherId", createdAnnotation?["annotationId"]);
               final currentAnnotationsList =
              await database.getAllAnnotations("anotherId");
          expect(currentAnnotationsList?.isEmpty, equals(true));
        },
      );
      test(
        "Fail deleting the annotation",
        () async {
          final createdAnnotation =
              await database.createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation?["annotationId"] != null, equals(true));
          final annotationsList =
              await database.getAllAnnotations("operatorId");
          expect(annotationsList?.isNotEmpty, equals(true));
          await database.deleteAnnotation("operatorId", null);
           final currentAnnotationsList =
              await database.getAllAnnotations("operatorId");
          expect(currentAnnotationsList?.isEmpty, equals(false));
        },
      );
    },
  );
}
