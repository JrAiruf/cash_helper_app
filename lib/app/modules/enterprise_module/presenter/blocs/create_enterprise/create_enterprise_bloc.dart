import 'package:cash_helper_app/app/modules/enterprise_module/domain/usecases/create_enterprise_account/icreate_enterprise_account.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/presenter/blocs/create_enterprise/create_enterprise_events.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/presenter/blocs/create_enterprise/create_enterprise_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEnterpriseBLoc
    extends Bloc<CreateEnterpriseEvents, CreateEnterpriseStates> {
  CreateEnterpriseBLoc({required ICreateEnterpriseAccount createEnterprise})
      : _createEnterprise = createEnterprise,
        super(CreateEnterpriseInitialState()) {
    on<CreateEnterpriseEvent>(_mapCreateEnterpriseEventToState);
  }
  final ICreateEnterpriseAccount _createEnterprise;

  void _mapCreateEnterpriseEventToState(
      CreateEnterpriseEvent createEnterprise, Emitter<CreateEnterpriseStates> state) async {
    state(CreateEnterpriseLoadingState());
    final enterprise = await _createEnterprise(createEnterprise.newEnterprise);
    if(enterprise != null) {
      state(CreateEnterpriseSuccessState(enterprise));
    } else {
      state(CreateEnterpriseErrorState("Criação não finalizada."));
    }
  }
}
