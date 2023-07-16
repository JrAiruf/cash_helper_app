import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/models/annotation_model.dart';

import '../../../../helpers/data_verifier.dart';
import '../../external/data/application_annotations_database.dart';

class AnnotationRepositoryImpl implements AnnotationRepository {
  AnnotationRepositoryImpl({required ApplicationAnnotationDatabase datasource, required DataVerifier dataVerifier})
      : _datasource = datasource,
        _dataVerifier = dataVerifier;
  final ApplicationAnnotationDatabase _datasource;
  final DataVerifier _dataVerifier;
  @override
  Future<AnnotationModel?>? createAnnotation(String? enterpriseId, String? operatorId, AnnotationModel? annotation) async {
    if (_dataVerifier.validateInputData(inputs: [enterpriseId, operatorId]) && _dataVerifier.objectVerifier(object: annotation!.toMap())) {
      final datasourceAnnotation = await _datasource.createAnnotation(enterpriseId!, operatorId!, annotation.toMap());
      return AnnotationModel.fromMap(datasourceAnnotation!);
    } else {
      return null;
    }
  }

  @override
  Future<AnnotationModel?>? getAnnotationById(String? enterpriseId, String? operatorId, String? annotationId) async {
    if (enterpriseId!.isNotEmpty && operatorId!.isNotEmpty && annotationId!.isNotEmpty) {
      final datasourceAnnotation = await _datasource.getAnnotationById(enterpriseId, operatorId, annotationId);
      return AnnotationModel.fromMap(datasourceAnnotation ?? {});
    } else {
      return null;
    }
  }

  @override
  Future<List<AnnotationModel>?>? getAllAnnotations(String? enterpriseId) async {
    final datasoourceAnnotationsList = await _datasource.getAllAnnotations(enterpriseId!);
    if (enterpriseId.isNotEmpty) {
      final annotationsModelList = datasoourceAnnotationsList?.map((annotationMap) => AnnotationModel.fromMap(annotationMap)).toList();
      return annotationsModelList;
    } else {
      return [];
    }
  }

  @override
  Future<List<AnnotationModel>?>? getAllPendingAnnotations(String? enterpriseId) async {
    final datasoourceAnnotationsList = await _datasource.getAllPendingAnnotations(enterpriseId!);
    if (enterpriseId.isNotEmpty) {
      final annotationsModelList = datasoourceAnnotationsList?.map((annotationMap) => AnnotationModel.fromMap(annotationMap)).toList();
      return annotationsModelList;
    } else {
      return [];
    }
  }
  
  @override
  Future<List<AnnotationModel>?>? searchAnnotationsByClientAddress(String? operatorId, String? clientAddress) async {
    final datasourceSugestedMaps = await _datasource.searchAnnotationsByClientAddress(operatorId!, clientAddress!);
    if (operatorId.isNotEmpty && clientAddress.isNotEmpty) {
      final repositorySugestedAnnotations = datasourceSugestedMaps?.map((annotationMap) => AnnotationModel.fromMap(annotationMap)).toList();
      return repositorySugestedAnnotations;
    } else {
      return [];
    }
  }

   @override
  Future<void>? updateAnnotation(String? enterpriseId, String? operatorId, String? annotationId, AnnotationModel? annotation) async {
    if (annotationId!.isNotEmpty && !annotation!.toMap().values.contains(null)) {
      await _datasource.updateAnnotation(enterpriseId!, operatorId!, annotationId, annotation.toMap());
    } else {
      return;
    }
  }

  @override
  Future<void>? finishAnnotation(String? enterpriseId, String? operatorId, String? annotationId) async {
    if (enterpriseId!.isNotEmpty && operatorId!.isNotEmpty && annotationId!.isNotEmpty) {
      await _datasource.finishAnnotation(enterpriseId, operatorId, annotationId);
    } else {
      return;
    }
  }

  @override
  Future<void>? deleteAnnotation(String? enterpriseId, String? operatorId, String? annotationId) async {
    if (enterpriseId!.isNotEmpty && operatorId!.isNotEmpty && annotationId!.isNotEmpty) {
      await _datasource.deleteAnnotation(enterpriseId, operatorId, annotationId);
    } else {
      return;
    }
  }

  @override
  Future<void>? createPendingAnnotation(String? enterpriseId, String? operatorId, String? annotationId) {
    // TODO: implement createPendingAnnotation
    throw UnimplementedError();
  }
  

}
