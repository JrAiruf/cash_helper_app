part of 'get_recent_activities_bloc.dart';

@immutable
abstract class GetRecentActivitiesStates {}

class GetRecentActivitiesInitialState extends GetRecentActivitiesStates {}

class GetRecentActivitiesLoadingState extends GetRecentActivitiesStates {}

class GetRecentActivitiesSuccessState extends GetRecentActivitiesStates {
  final List<PendencyEntity> pendencies;
  final List<AnnotationEntity> annotations;
  final List<OperatorEntity> operators;

  GetRecentActivitiesSuccessState(this.operators, this.pendencies, this.annotations);
}

class NoRecentActivitiesState extends GetRecentActivitiesStates {}
