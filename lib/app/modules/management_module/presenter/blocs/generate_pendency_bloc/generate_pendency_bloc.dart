import 'package:bloc/bloc.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/pendencies/generate_pendency/igenerate_pendency.dart';
import 'package:meta/meta.dart';

part 'generate_pendency_events.dart';
part 'generate_pendency_states.dart';

class GeneratePendencyBloc extends Bloc<GeneratePendencyEvents, GeneratePendencyStates> {
  GeneratePendencyBloc({required IGeneratePendency generatePendency})
      : _generatePendency = generatePendency,
        super(GeneratePendencyInitialState()) {
    on<GeneratePendencyEvent>(_mapGeneratePendencyEventToState);
  }

  final IGeneratePendency _generatePendency;
  void _mapGeneratePendencyEventToState(GeneratePendencyEvent event, Emitter<GeneratePendencyStates> state) async {
    state(GeneratePendencyLoadingState());
    await _generatePendency(event.enterpriseId, event.pendency)?.catchError((e) {
      state(GeneratePendencyFailureState("Falha ao gerar pendência"));
    });
    state(GeneratePendencySuccessState());
  }
}
