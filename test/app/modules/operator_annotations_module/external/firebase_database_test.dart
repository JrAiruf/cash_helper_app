import 'package:cash_helper_app/app/modules/operator_annotations_module/external/data/application_annotations_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

import '../../login_module/infra/repository/login_repository_impl_test.dart';

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
  Future<List<Map<String, dynamic>>?>? getAllAnnotations(String? operatorId) {
    // TODO: implement getAllAnnotations
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?>? getAnnotationById(
      String? operatorId, String? annotationId) {
    // TODO: implement getAnnotationById
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>?>? searchAnnotationsByClientAddress(
      String? operatorId, String? clientAddress) {
    // TODO: implement searchAnnotationsByClientAddress
    throw UnimplementedError();
  }

  @override
  Future<void>? finishAnnotation(String? operatorId, String? annotationId) {
    // TODO: implement finishAnnotation
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?>? updateAnnotation(String? operatorId,
      String? annotationId, Map<String, dynamic>? annotation) {
    // TODO: implement updateAnnotation
    throw UnimplementedError();
  }

  @override
  Future<void>? deleteAnnotation(String? operatorId, String? annotationId) {
    // TODO: implement deleteAnnotation
    throw UnimplementedError();
  }
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
  final firebaseMock = FakeFirebaseFirestore();
  final uuid = Uuid();
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
}
