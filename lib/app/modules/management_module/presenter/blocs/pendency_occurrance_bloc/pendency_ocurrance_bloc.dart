// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_annotations/iget_all_annotations.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_all_operators/iget_all_operators.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/pendencies/get_all_pendencies/iget_all_pendencies.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';

import '../../../../annotations_module/domain/entities/annotation_entity.dart';

part 'pendency_ocurrance_events.dart';
part 'pendency_ocurrance_states.dart';

class PendencyOcurranceBloc extends Bloc<PendencyOcurranceEvents, PendencyOcurranceStates> {
  PendencyOcurranceBloc({
    required IGetAllOperators getAllOperators,
    required IGetAllAnnotations getAllAnnotations,
    required IGetAllPendencies getAllPendencies,
  })  : _getAllOperators = getAllOperators,
        _getAllAnnotations = getAllAnnotations,
        _getAllPendencies = getAllPendencies,
        super(PendencyOcurranceInitialState()) {
    on<PendencyOcurranceEvent>(_mapPendencyOcurranceEventToState);
  }

  final IGetAllOperators _getAllOperators;
  final IGetAllAnnotations _getAllAnnotations;
  final IGetAllPendencies _getAllPendencies;
  void _mapPendencyOcurranceEventToState(PendencyOcurranceEvent event, Emitter<PendencyOcurranceStates> state) async {
    state(PendencyOcurranceLoadingState());
    final operators = await _getAllOperators(event.enterpriseId)?.catchError((e) {
          return <OperatorEntity>[];
        }) ??
        [];
    final annotations = await _getAllAnnotations(event.enterpriseId)?.catchError((e) {
      return <AnnotationEntity>[];
    });
    final pendencies = await _getAllPendencies(event.enterpriseId).catchError((e) {
      state(PendencyOcurranceFailureState());
      return <PendencyEntity>[];
    });
    if (pendencies.isNotEmpty) {
      final pendenciesList = pendencies.where((pendency) => !pendency.pendencyFinished! == false).toList();
      state(PendencyOcurranceSuccessState(operators, annotations, pendenciesList));
    }
  }
}
