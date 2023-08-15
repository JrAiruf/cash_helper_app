import 'package:bloc/bloc.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/manager/ifinish_pendency.dart';
import 'package:meta/meta.dart';
part 'finish_pendency_events.dart';
part 'finish_pendency_states.dart';

class FinishPendencyBloc extends Bloc<FinishPendencyEvent, FinishPendencyStates> {
  FinishPendencyBloc({required IFinishPendency finishPendency})
      : _finishPendency = finishPendency,
        super(FinishPendencyInitialState()) {
    on<FinishPendencyEvent>(_mapFinishPendencyEventToState);
  }

  final IFinishPendency _finishPendency;

  void _mapFinishPendencyEventToState(FinishPendencyEvent event, Emitter<FinishPendencyStates> state) async {
    state(FinishPendencyLoadingState());
    await _finishPendency(event.enterpriseId, event.pendencyId).catchError((e) {
      state(FinishPendencyFailureState("Pendência não finalizada"));
      return null;
    });
    state(FinishPendencySuccessState());
  }
}
