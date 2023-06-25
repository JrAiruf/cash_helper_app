import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';

abstract class IGeneratePendency {
  Future<PendencyEntity> call(String enterpriseId,String operatorId,String annotationId);
}
