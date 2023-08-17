import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'generate_pendency_events.dart';
part 'generate_pendency_states.dart';

class GeneratePendencyBloc extends Bloc<GeneratePendencyEvents, GeneratePendencyStates> {
  GeneratePendencyBloc() : super(GeneratePendencyInitial()) {
    on<GeneratePendencyEvents>((event, emit) {
      // TODO: implement event handler
    });
  }
}
