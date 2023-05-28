// ignore_for_file: unused_field

import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_annotations/iget_all_annotations.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/search_annotations_by_client_address/isearch_annotations_by_client_address.dart';
import 'package:flutter/foundation.dart';

class AnnotationsListStore extends ValueNotifier<List<AnnotationEntity>> {
  AnnotationsListStore({
    required IGetAllAnnotations getAllAnnotations,
    required ISearchAnnotationsByClientAddress searchAnnotationsByClientAddress,
  })  : _getAllAnnotations = getAllAnnotations,
        _searchAnnotationsByClientAddress = searchAnnotationsByClientAddress,
        super([]);

  final IGetAllAnnotations _getAllAnnotations;
  final ISearchAnnotationsByClientAddress _searchAnnotationsByClientAddress;

  final loadingAnnotations = ValueNotifier(false);
  Future<void> getAllAnnotations(String? operatorId) async {
    loadingAnnotations.value = true;
    final annotationsList =
        await _getAllAnnotations(operatorId) as List<AnnotationEntity>;
    if (annotationsList.isNotEmpty) {
      value = annotationsList;
      loadingAnnotations.value = false;
    } else {
      value = [];
      loadingAnnotations.value = false;
    }
  }
}
