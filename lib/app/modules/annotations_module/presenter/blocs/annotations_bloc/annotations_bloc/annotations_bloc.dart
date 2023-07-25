import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/create_annotation/icreate_new_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/blocs/annotations_bloc/annotations_bloc/annotations_events.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/blocs/annotations_bloc/annotations_bloc/annotations_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnnotationsBloc extends Bloc<AnnotationsEvents, AnnotationsStates> {
  AnnotationsBloc({required ICreateNewAnnotation createNewAnnotation})
      : _createNewAnnotation = createNewAnnotation,
        super(AnnotationsInitialState()) {
    on<CreateAnnotationEvent>(_mapCreateNewAnnotationEventToState);
  }

  final ICreateNewAnnotation _createNewAnnotation;
  void _mapCreateNewAnnotationEventToState(CreateAnnotationEvent event, Emitter<AnnotationsStates> state) async {
    state(AnnotationsLoadingState());
    final annotation = await _createNewAnnotation(event.enterpriseId, event.annotation)?.catchError((e) {
      state(AnnotationsErrorState());
      return null;
    });
    if (annotation != null) {
      state(AnnotationsSuccessState(annotation));
    }
  }
}
