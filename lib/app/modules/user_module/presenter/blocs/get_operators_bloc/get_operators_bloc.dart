// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'get_operators_event.dart';
part 'get_operators_state.dart';

class GetOperatorsBloc extends Bloc<GetOperatorsEvents, GetOperatorsState> {
  GetOperatorsBloc() : super(GetOperatorsInitialState()) {
    on<GetOperatorsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  void _mapGetAllOperatorsEventToState() {}
}
