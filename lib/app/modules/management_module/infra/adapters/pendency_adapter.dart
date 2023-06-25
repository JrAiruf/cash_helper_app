import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';

class PendencyAdapter {
  static PendencyEntity fromMap(Map data) {
    return PendencyEntity(
      annotationId: data["annotationId"],
      pendencyPeriod: data["pendencyPeriod"],
      operatorId: data["operatorId"],
    );
  }
}
