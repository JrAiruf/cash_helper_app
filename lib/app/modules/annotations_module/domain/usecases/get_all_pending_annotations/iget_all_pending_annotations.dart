import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';

abstract class IGetAllPendingAnnotations {
  Future<List<AnnotationEntity>>? call(String enterpriseId);
}
