import 'package:bloc/bloc.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_annotations/iget_all_annotations.dart';
import 'package:meta/meta.dart';
part 'get_annotations_events.dart';
part 'get_annotations_states.dart';

class GetAnnotationsBloc extends Bloc<GetAnnotationsEvent, GetAnnotationsStates> {
  GetAnnotationsBloc({required IGetAllAnnotations getAllAnnotations})
      : _getAllAnnotations = getAllAnnotations,
        super(GetAnnotationsInitialState()) {
    on<GetAnnotationsEvent>(_mapGetAnnotationsEventToState);
  }

  final IGetAllAnnotations _getAllAnnotations;
  void _mapGetAnnotationsEventToState(GetAnnotationsEvent event, Emitter<GetAnnotationsStates> state) async {
    state(GetAnnotationsLoadingState());
    final annotations = await _getAllAnnotations(event.enterpriseId)?.catchError((e) {
      state(GetAnnotationsFailureState(e.toString()));
      return <AnnotationEntity>[];
    }) as List<AnnotationEntity>;
    if (annotations.isNotEmpty) {
      state(GetAnnotationsSuccessState(annotations));
    }
  }
}
