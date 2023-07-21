import 'package:cash_helper_app/app/modules/enterprise_module/domain/usecases/get_enterprise_by_code/iget_enterprise_by_code.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/presenter/blocs/get_enterprise_by_code/get_enterprise_by_code_events.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/presenter/blocs/get_enterprise_by_code/get_enterprise_by_code_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetEnterpriseByCodeBloc extends Bloc<GetEnterpriseByCodeEvents, GetEnterpriseByCodeStates> {
  GetEnterpriseByCodeBloc({required IGetEnterpriseByCode getEnterpriseByCode})
      : _getEnterpriseByCode = getEnterpriseByCode,
        super(GetEnterpriseInitialState()) {
    on<GetEnterpriseByCodeEvent>(_mapGetEnterpriseByCodeEventToState);
    on<InitialAppEvent>(_setInitialState);
  }

  final IGetEnterpriseByCode _getEnterpriseByCode;
  void _mapGetEnterpriseByCodeEventToState(GetEnterpriseByCodeEvent event, Emitter<GetEnterpriseByCodeStates> state) async {
    state(GetEnterpriseLoadingState());
    final enterprise = await _getEnterpriseByCode(event.enterpriseCode)?.catchError((e) {
      state(GetEnterpriseErrorState("O código não pertence a nenhuma empresa cadastrada"));
    });
    if (enterprise != null) {
      state(GetEnterpriseSuccessState(enterprise));
    }
  }

  void _setInitialState(InitialAppEvent event, Emitter<GetEnterpriseByCodeStates> state) {
    state(GetEnterpriseInitialState());
  }
}
