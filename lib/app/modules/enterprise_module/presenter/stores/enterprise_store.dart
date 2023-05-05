import 'package:cash_helper_app/app/modules/enterprise_module/presenter/stores/enterprise_states.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entities/enterprise_entity.dart';
import '../../domain/usecases/create_enterprise_account/icreate_enterprise_account.dart';
import '../../domain/usecases/get_enterprise_by_code/iget_enterprise_by_code.dart';

class EnterpriseStore extends ValueNotifier<EnterpriseStates> {
  EnterpriseStore({
    required ICreateEnterpriseAccount createEnterpriseAccount,
    required IGetEnterpriseByCode getEnterpriseByCode,
  })  : _createEnterpriseAccount = createEnterpriseAccount,
        _getEnterpriseByCode = getEnterpriseByCode,
        super(EnterpriseStoreInitialState());

  final ICreateEnterpriseAccount _createEnterpriseAccount;
  final IGetEnterpriseByCode _getEnterpriseByCode;

  Future<void> createEnterpriseAccount(
      EnterpriseEntity enterpriseEntity) async {
    value = LoadingState();
    final enterprise = await _createEnterpriseAccount(enterpriseEntity);
    if (enterprise != null) {
      value = CreatedEnterpriseState(enterprise: enterprise);
    } else {
      value = CreationFailedState();
    }
  }
}
