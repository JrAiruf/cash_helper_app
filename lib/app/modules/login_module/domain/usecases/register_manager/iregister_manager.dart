import 'package:cash_helper_app/app/modules/user_module/domain/entities/manager_entity.dart';

abstract class IRegisterManager {
  Future<dynamic> call(ManagerEntity? managerEntity, String? enterpriseId, String? collection);
}
