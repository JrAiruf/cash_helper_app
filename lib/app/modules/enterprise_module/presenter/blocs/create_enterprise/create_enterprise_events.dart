import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';

abstract class CreateEnterpriseEvents {}

class CreateEnterpriseEvent implements CreateEnterpriseEvents {
CreateEnterpriseEvent(this.newEnterprise);
  final EnterpriseEntity newEnterprise;
}