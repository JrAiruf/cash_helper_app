// ignore_for_file: unused_element

import 'package:cash_helper_app/app/modules/annotations_module/external/data/application_annotations_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AnnotationsDatabase implements ApplicationAnnotationDatabase {
  AnnotationsDatabase({required FirebaseFirestore database, required this.uuidGenertor}) : _database = database;

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
  Future<Map<String, dynamic>?>? createPendingAnnotation(String? enterpriseId, Map<String, dynamic>? annotation) async {
    if (enterpriseId != null && annotation != null) {
      await _createPendingAnnotation(enterpriseId, annotation);
      final currentAnnotation = await _database.collection("enterprise").doc(enterpriseId).collection("pendingAnnotations").doc(annotation["annotationId"]).get().then((value) => value.data());
      return currentAnnotation!.isEmpty ? null : currentAnnotation;
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
  Future<void>? updateAnnotation(String? enterpriseId, String? operatorId, String? annotationId, Map<String, dynamic>? annotation) async {
    final annotationsCollection = _getCollection(enterpriseId);
    if (enterpriseId!.isNotEmpty && operatorId!.isNotEmpty && annotationId!.isNotEmpty) {
      await annotationsCollection.doc(annotationId).update(annotation!);
    } else {
      return;
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
