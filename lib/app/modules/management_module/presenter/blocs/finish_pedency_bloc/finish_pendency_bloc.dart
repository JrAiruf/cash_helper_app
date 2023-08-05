import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'finish_pendency_events.dart';
part 'finish_pendency_states.dart';

class FinishPendencyBloc extends Bloc<FinishPendencyEvent, FinishPendencyStates> {
  FinishPendencyBloc() : super(FinishPendencyInitial()) {
    on<FinishPendencyEvent>(_mapFinishPendencyEventToState);
  }

  void _mapFinishPendencyEventToState(FinishPendencyEvent event, Emitter<FinishPendencyStates> state) async {}
}
