import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_annotations/iget_all_annotations.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/search_annotations_by_client_address/isearch_annotations_by_client_address.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotation_states.dart';
import 'package:flutter/foundation.dart';

class AnnotationsListStore extends ValueNotifier<AnnotationsListStates> {
  AnnotationsListStore({
    required IGetAllAnnotations getAllAnnotations,
    required ISearchAnnotationsByClientAddress searchAnnotationsByClientAddress,
  })  : _getAllAnnotations = getAllAnnotations,
        _searchAnnotationsByClientAddress = searchAnnotationsByClientAddress,
        super(InitialAnnotationsListState());

  final IGetAllAnnotations _getAllAnnotations;
  final ISearchAnnotationsByClientAddress _searchAnnotationsByClientAddress;

  Future<void> getAllAnnotations(String? operatorId) async {
    value = LoadingAnnotationsListState();
    final annotationsList = await _getAllAnnotations(operatorId) ?? [];
    if (annotationsList.isNotEmpty) {
      value = RetrievedAnnotationsListState(annotationsList: annotationsList);
    } else {
      value = EmptyAnnotationsListState();
    }
  }
}
