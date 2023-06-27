import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';

abstract class IGetAllPendencies {
  Future<List<PendencyEntity>> call(String enterpriseId);
}
