part of 'pendency_ocurrance_bloc.dart';

@immutable
abstract class PendencyOcurranceEvents {}

class PendencyOcurranceEvent implements PendencyOcurranceEvents {
  final String enterpriseId;

  PendencyOcurranceEvent(this.enterpriseId);
}
