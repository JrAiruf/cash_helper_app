// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_annotations/iget_all_annotations.dart';
import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_all_operators/iget_all_operators.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/pendencies/get_all_pendencies/iget_all_pendencies.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:meta/meta.dart';
part 'get_recent_activities_events.dart';
part 'get_recent_activities_states.dart';

class GetRecentActivitiesBloc extends Bloc<GetRecentActivitiesEvents, GetRecentActivitiesStates> {
  GetRecentActivitiesBloc({
    required IGetAllOperators getAllOperators,
    required IGetAllAnnotations getAllAnnotations,
    required IGetAllPendencies getAllPendencies,
  })  : _getAllOperators = getAllOperators,
        _getAllAnnotations = getAllAnnotations,
        _getAllPendencies = getAllPendencies,
        super(GetRecentActivitiesInitialState()) {
    on<GetRecentActivitiesEvent>(_mapGetAllOperatorsEventToState);
  }
  final IGetAllOperators _getAllOperators;
  final IGetAllAnnotations _getAllAnnotations;
  final IGetAllPendencies _getAllPendencies;
  void _mapGetAllOperatorsEventToState(GetRecentActivitiesEvent event, Emitter<GetRecentActivitiesStates> state) async {
    state(GetRecentActivitiesLoadingState());
    final operators = await _getAllOperators(event.enterpriseId)?.catchError((e) {
      state(GetRecentActivitiesFailureState());
      return <OperatorEntity>[];
    });
    if (operators!.isNotEmpty) {
      final annotations = await _getAllAnnotations(event.enterpriseId);
      final pendecies = await _getAllPendencies(event.enterpriseId);
      state(GetRecentActivitiesSuccessState(operators, pendecies, annotations));
    }
  }
}
