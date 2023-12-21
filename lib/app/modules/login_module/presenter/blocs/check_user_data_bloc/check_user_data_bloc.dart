import 'package:bloc/bloc.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/check_operator_data_for_reset_password/icheck_user_data_for_reset_password.dart';
import 'package:meta/meta.dart';

part 'check_user_data_event.dart';
part 'check_user_data_state.dart';

class CheckUserDataBloc extends Bloc<CheckUserDataEvent, CheckUserDataStates> {
  CheckUserDataBloc({required ICheckUserDataForResetPassword checkUserData})
      : _checkUserData = checkUserData,
        super(CheckUserDataInitialState()) {
    on<CheckUserDataEvent>(_mapCheckUserDataEventToState);
  }

  final ICheckUserDataForResetPassword _checkUserData;
  void _mapCheckUserDataEventToState(CheckUserDataEvent event, Emitter<CheckUserDataStates> state) async {
    state(CheckUserDataLoadingState());
    final checked = await _checkUserData(event.enterpriseId, event.userEmail, event.userCode, event.businessPosition);
    if (checked) {
      state(CheckUserDataSuccessState());
    } else {
      state(CheckUserDataFailureState("Dados inválidos! Verifique os dados e tente novamente."));
    }
  }
}
