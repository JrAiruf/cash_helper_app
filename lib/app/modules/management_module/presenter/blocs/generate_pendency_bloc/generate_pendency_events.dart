part of 'generate_pendency_bloc.dart';

@immutable
abstract class GeneratePendencyEvents {}

class GeneratePendencyEvent implements GeneratePendencyEvents {
  final String enterpriseId;
  final PendencyEntity pendency;

  GeneratePendencyEvent(this.enterpriseId, this.pendency);
}
