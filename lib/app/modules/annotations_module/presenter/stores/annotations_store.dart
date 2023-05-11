// ignore_for_file: unused_field

import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/create_annotation/icreate_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/delete_annotation/idelete_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/finish_annotation/ifinish_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_annotation_by_id/iget_annotation_by_id.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/update_annotation/iupdate_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotation_states.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/entities/annotation_entity.dart';
import '../../domain/usecases/create_annotation/icreate_new_annotation.dart';

class AnnotationStore extends ValueNotifier<AnnotationStates> {
  AnnotationStore({
    required ICreateNewAnnotation createNewAnnotation,
    required IGetAnnotationById getAnnotationById,
    required IUpdateAnnotation updateAnnotation,
    required IFinishAnnotation finishAnnotation,
    required IDeleteAnnotation deleteAnnotation,
  })  : _createNewAnnotation = createNewAnnotation,
        _getAnnotationById = getAnnotationById,
        _updateAnnotation = updateAnnotation,
        _finishAnnotation = finishAnnotation,
        _deleteAnnotation = deleteAnnotation,
        super(InitialAnnotationState());

  final ICreateNewAnnotation _createNewAnnotation;
  final IGetAnnotationById _getAnnotationById;
  final IUpdateAnnotation _updateAnnotation;
  final IFinishAnnotation _finishAnnotation;
  final IDeleteAnnotation _deleteAnnotation;
//CRIAR
  Future<void>? createNewAnnotation(String enterpriseId,
      String operatorId, AnnotationEntity annotation) async {
    final newAnnotation = await _createNewAnnotation(enterpriseId, operatorId, annotation);
    return newAnnotation;
  }
//BUSCAR PELO ID
//ATUALIZAR
//FINALIZAR
//DELETAR
}
