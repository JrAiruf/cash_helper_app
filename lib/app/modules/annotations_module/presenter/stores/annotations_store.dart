import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotation_states.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/contract/annotation_usecases.dart';
import '../../domain/entities/annotation_entity.dart';

class AnnotationStore extends ValueNotifier<AnnotationStates> {
  AnnotationStore({required AnnotationUsecases usecases}) : _usecases = usecases, super(InitialAnnotationState());

final AnnotationUsecases _usecases;

  Future<AnnotationEntity?>? createAnnotation(String? operatorId, AnnotationEntity annotation) async {
    final newAnnotation = await _usecases.createAnnotation(operatorId, annotation);
    return newAnnotation;
  }
}