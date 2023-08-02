part of 'get_recent_activities_bloc.dart';

@immutable
abstract class GetRecentActivitiesEvents {}

class GetRecentActivitiesEvent implements GetRecentActivitiesEvents {
  final String enterpriseId;

  GetRecentActivitiesEvent(this.enterpriseId);
}
