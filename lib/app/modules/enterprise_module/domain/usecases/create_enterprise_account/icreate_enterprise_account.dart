import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';

abstract class ICreateEnterpriseAccount {
  Future<dynamic>? call(EnterpriseEntity enterpriseEntity);
}
