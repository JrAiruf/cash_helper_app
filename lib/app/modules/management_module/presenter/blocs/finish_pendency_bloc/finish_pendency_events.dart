part of 'finish_pendency_bloc.dart';

@immutable
abstract class FinishPendencyEvents {}

class FinishPendencyEvent implements FinishPendencyEvents {
  final String enterpriseId;
  final String pendencyId;

  FinishPendencyEvent(this.enterpriseId, this.pendencyId);
}
