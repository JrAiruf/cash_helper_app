import 'package:cash_helper_app/app/modules/annotations_module/domain/contract/annotation_usecases.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import '../../infra/data/annotation_repository.dart';
import '../../infra/models/annotation_model.dart';

class AnnotationUsecasesImpl implements AnnotationUsecases {
  AnnotationUsecasesImpl({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  @override
  Future<AnnotationEntity?>? createAnnotation(
      String? operatorId, AnnotationEntity? annotation) async {
    if (operatorId!.isNotEmpty && annotation != null) {
      final annotationModel = AnnotationModel.fromEntityData(annotation);
      final usecaseAnnotation = await _repository.createAnnotation(operatorId, annotationModel);
      return AnnotationModel.toEntityData(usecaseAnnotation!);
    } else {
      return null;
    }
  }

  @override
  Future<AnnotationEntity?>? getAnnotationById(
      String? operatorId, String? annotationId) async {
        if (operatorId!.isNotEmpty && annotationId!.isNotEmpty) {
    final annotationModel = await _repository.getAnnotationById(operatorId, annotationId);
    final usecasesAnnotation = AnnotationModel.toEntityData(annotationModel!);
    return usecasesAnnotation;      
        } else {
          return null;
        }
  }

  @override
  Future<List<AnnotationEntity>?>? getAllAnnotations(String? operatorId) async {
    if(operatorId!.isNotEmpty){
    final annotationModelList = await _repository.getAllAnnotations(operatorId);
    final annotationEntityList = annotationModelList
        ?.map(
            (annotationModel) => AnnotationModel.toEntityData(annotationModel))
        .toList();
    return annotationEntityList;
    } else {
      return [];
    }
  }

  @override
  Future<List<AnnotationEntity>?>? searchAnnotationsByClientAddress(
      String? operatorId, String? clientAddress) async {
        if(operatorId!.isNotEmpty && clientAddress!.isNotEmpty){
    final annotationModelList = await _repository
        .searchAnnotationsByClientAddress(operatorId, clientAddress);
    final annotationEntityList = annotationModelList
        ?.map(
            (annotationModel) => AnnotationModel.toEntityData(annotationModel))
        .toList();
    return annotationEntityList;
        } else {
          return [];
        }
  }

  @override
  Future<void>? updateAnnotation(String? operatorId, String? annotationId,
      AnnotationEntity? annotation) async {
        if(operatorId!.isNotEmpty && annotationId!.isNotEmpty){
    final annotationModel = AnnotationModel.fromEntityData(annotation!);
    await _repository.updateAnnotation(
        operatorId, annotationId, annotationModel);
        } else {
          return;
        }
  }

  @override
  Future<void>? finishAnnotation(
      String? operatorId, String? annotationId) async {
    await _repository.finishAnnotation(operatorId, annotationId);
  }

  @override
  Future<void>? deleteAnnotation(
      String? operatorId, String? annotationId) async {
    await _repository.deleteAnnotation(operatorId, annotationId);
  }
}
