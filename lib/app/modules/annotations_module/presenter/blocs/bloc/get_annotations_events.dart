part of 'get_annotations_bloc.dart';

@immutable
abstract class GetAnnotationsEvents {}

class GetAnnotationsEvent implements GetAnnotationsEvents {
  final String enterpriseId;

  GetAnnotationsEvent(this.enterpriseId);
}
