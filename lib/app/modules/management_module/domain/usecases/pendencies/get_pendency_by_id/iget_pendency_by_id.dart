import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';

abstract class IGetPendencyById {
  Future<PendencyEntity> call(String enterpriseId, String pendencyId);
}
