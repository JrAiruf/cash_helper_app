import 'package:cash_helper_app/app/modules/annotations_module/domain/contract/annotation_usecases.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotation_states.dart';
import 'package:flutter/foundation.dart';

class AnnotationsListStore extends ValueNotifier<AnnotationsListStates> {
  AnnotationsListStore({required AnnotationUsecases usecases}) : _usecases = usecases, super(InitialAnnotationsListState());

  final AnnotationUsecases _usecases;

  Future<List<AnnotationEntity>> getAllAnnotations(String? operatorId) async {
    final annotationsList = await _usecases.getAllAnnotations(operatorId) ?? [];
    return annotationsList;
  }
}
