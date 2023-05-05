import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';

abstract class IGetEnterpriseByCode {
  Future<dynamic>? call(String enterpriseCode);
}
