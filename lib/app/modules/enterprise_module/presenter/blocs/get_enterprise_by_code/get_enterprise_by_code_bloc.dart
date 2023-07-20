import 'package:cash_helper_app/app/modules/enterprise_module/presenter/blocs/get_enterprise_by_code/get_enterprise_by_code_events.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/presenter/blocs/get_enterprise_by_code/get_enterprise_by_code_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetEnterpriseByCodeBloc extends Bloc<GetEnterpriseByCodeEvents,GetEnterpriseByCodeStates>{
  GetEnterpriseByCodeBloc() : super(GetEnterpriseInitialState()) {

  }

  void _mapEventToState(GetEnterpriseByCodeEvent event, Emitter<GetEnterpriseByCodeStates> state) async {}
}