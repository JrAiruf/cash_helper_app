import 'package:bloc/bloc.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/update_annotation/iupdate_annotation.dart';
import 'package:meta/meta.dart';
part 'update_annotation_events.dart';
part 'update_annotation_state.dart';

class UpdateAnnotationBloc extends Bloc<UpdateAnnotationEvents, UpdateAnnotationStates> {
  UpdateAnnotationBloc({required IUpdateAnnotation updateAnnotation})
      : _updateAnnotation = updateAnnotation,
        super(UpdateAnnotationInitialState()) {
    on<UpdateAnnotationEvent>(_mapUpdateAnnotationEventToState);
  }
  final IUpdateAnnotation _updateAnnotation;
  void _mapUpdateAnnotationEventToState(UpdateAnnotationEvent event, Emitter<UpdateAnnotationStates> state) async {
    state(UpdateAnnotationLoadingState());
    await _updateAnnotation(event.enterpriseId, event.annotation)?.catchError((e) {
      state(UpdateAnnotationFailureState());
    });
    state(UpdateAnnotationSuccessState());
  }
}
