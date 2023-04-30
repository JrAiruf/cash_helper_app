import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/create_annotation/icreate_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/delete_annotation/idelete_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/finish_annotation/ifinish_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_annotation_by_id/iget_annotation_by_id.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/update_annotation/iupdate_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotation_states.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/entities/annotation_entity.dart';

class AnnotationStore extends ValueNotifier<AnnotationStates> {
  AnnotationStore({
    required ICreateAnnotation createAnnotation,
    required IGetAnnotationById getAnnotationById,
    required IUpdateAnnotation updateAnnotation,
    required IFinishAnnotation finishAnnotation,
    required IDeleteAnnotation deleteAnnotation,
  })  : _createAnnotation = createAnnotation,
        _getAnnotationById = getAnnotationById,
        _updateAnnotation = updateAnnotation,
        _finishAnnotation = finishAnnotation,
        _deleteAnnotation = deleteAnnotation,
        super(InitialAnnotationState());

  final ICreateAnnotation _createAnnotation;
  final IGetAnnotationById _getAnnotationById;
  final IUpdateAnnotation _updateAnnotation;
  final IFinishAnnotation _finishAnnotation;
  final IDeleteAnnotation _deleteAnnotation;
//CRIAR
  Future<AnnotationEntity?>? createAnnotation(
      String? operatorId, AnnotationEntity annotation) async {
    final newAnnotation = await _createAnnotation(operatorId, annotation);
    return newAnnotation;
  }
//BUSCAR PELO ID
//ATUALIZAR
//FINALIZAR
//DELETAR
}
