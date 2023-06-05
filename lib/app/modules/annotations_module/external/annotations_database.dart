import 'package:cash_helper_app/app/modules/annotations_module/external/data/application_annotations_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AnnotationsDatabase implements ApplicationAnnotationDatabase {
  AnnotationsDatabase(
      {required FirebaseFirestore database, required this.uuidGenertor})
      : _database = database;

  final FirebaseFirestore _database;
  final Uuid uuidGenertor;
  Map<String, dynamic>? annotationData = {};

  @override
  Future<Map<String, dynamic>?>? createAnnotation(String? enterpriseId,
      String? operatorId, Map<String, dynamic>? annotation) async {
    final annotationsCollection = _database
        .collection("enterprise")
        .doc(enterpriseId)
        .collection("operator")
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
      String? enterpriseId, String? operatorId) async {
    final annotationsCollection = _getCollection(enterpriseId, operatorId);
    if (enterpriseId != null && operatorId != null) {
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
      String? enterpriseId, String? operatorId, String? annotationId) async {
    final annotationsCollection = _getCollection(enterpriseId, operatorId);
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
    throw UnimplementedError();
  }

  @override
  Future<void>? finishAnnotation(
      String? enterpriseId, String? operatorId, String? annotationId) async {
    final annotationsCollection = _getCollection(enterpriseId, operatorId);
    if (enterpriseId!.isNotEmpty &&
        operatorId!.isNotEmpty &&
        annotationId!.isNotEmpty) {
      await annotationsCollection
          .doc(annotationId)
          .update({"annotationConcluied": true});
    }
  }

  @override
  Future<void>? updateAnnotation(String? operatorId, String? annotationId,
      Map<String, dynamic>? annotation) async {
    throw UnimplementedError();
  }

  @override
  Future<void>? deleteAnnotation(
      String? enterpriseId, String? operatorId, String? annotationId) async {
    final annotationsCollection = _getCollection(enterpriseId, operatorId);
    if (enterpriseId!.isNotEmpty &&
        operatorId!.isNotEmpty &&
        annotationId!.isNotEmpty) {
      await annotationsCollection.doc(annotationId).delete();
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _filterSearchClientAddress(
          {required String operatorId, required String clientAddress}) async {
    final dividedSearchText = clientAddress.split(' ');
    final simpleSearchText = dividedSearchText[0];
    final databaseAnnotationsCollection =
        await _getCollection("",operatorId).get();
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
          String? enterpriseId, String? operatorId) =>
      _database
          .collection("enterprise")
          .doc(enterpriseId)
          .collection("operator")
          .doc(operatorId)
          .collection("annotations");
}
