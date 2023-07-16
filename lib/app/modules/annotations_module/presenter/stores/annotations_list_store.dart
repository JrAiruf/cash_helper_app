// ignore_for_file: unused_field

import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_annotations/iget_all_annotations.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_pending_annotations/iget_all_pending_annotations.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/search_annotations_by_client_address/isearch_annotations_by_client_address.dart';
import 'package:flutter/foundation.dart';

class AnnotationsListStore extends ValueNotifier<List<AnnotationEntity>> {
  AnnotationsListStore({
    required IGetAllAnnotations getAllAnnotations,
    required IGetAllPendingAnnotations getAllPendingAnnotations,
    required ISearchAnnotationsByClientAddress searchAnnotationsByClientAddress,
  })  : _getAllAnnotations = getAllAnnotations,
        _getAllPendingAnnotations = getAllPendingAnnotations,
        _searchAnnotationsByClientAddress = searchAnnotationsByClientAddress,
        super([]);

  final IGetAllAnnotations _getAllAnnotations;
  final IGetAllPendingAnnotations _getAllPendingAnnotations;
  final ISearchAnnotationsByClientAddress _searchAnnotationsByClientAddress;

  final loadingAnnotations = ValueNotifier(false);
  Future<void> getAllAnnotations(String? enterpriseId) async {
    loadingAnnotations.value = true;
    final annotationsList = await _getAllAnnotations(enterpriseId!) as List<AnnotationEntity>;
    if (annotationsList.isNotEmpty) {
      value = annotationsList;
      loadingAnnotations.value = false;
    } else {
      value = [];
      loadingAnnotations.value = false;
    }
  }
  Future<void> getAllPendingAnnotations(String? enterpriseId) async {
    loadingAnnotations.value = true;
    final pendingAnnotationsList = await _getAllPendingAnnotations(enterpriseId!) as List<AnnotationEntity>;
    if (pendingAnnotationsList.isNotEmpty) {
      value = pendingAnnotationsList;
      loadingAnnotations.value = false;
    } else {
      value = [];
      loadingAnnotations.value = false;
    }
  }
}
