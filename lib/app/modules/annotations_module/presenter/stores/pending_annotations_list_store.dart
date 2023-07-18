import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_pending_annotations/iget_all_pending_annotations.dart';
import 'package:flutter/material.dart';

class PendingAnnotationsListStore extends ValueNotifier<List<AnnotationEntity>> {
  PendingAnnotationsListStore({
    required IGetAllPendingAnnotations getAllPendingAnnotations,
  })  : _getAllPendingAnnotations = getAllPendingAnnotations,
        super([]);

  final IGetAllPendingAnnotations _getAllPendingAnnotations;

  final loadingAnnotations = ValueNotifier(false);
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
