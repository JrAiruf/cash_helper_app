import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/create_annotation/icreate_new_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/blocs/annotations_bloc/create_annotations_bloc/create_annotations_events.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/blocs/annotations_bloc/create_annotations_bloc/create_annotations_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAnnotationsBloc extends Bloc<AnnotationsEvents, CreateAnnotationsStates> {
  CreateAnnotationsBloc({required ICreateNewAnnotation createNewAnnotation})
      : _createNewAnnotation = createNewAnnotation,
        super(CreateAnnotationsInitialState()) {
    on<CreateAnnotationEvent>(_mapCreateNewAnnotationEventToState);
  }

  final ICreateNewAnnotation _createNewAnnotation;
  void _mapCreateNewAnnotationEventToState(CreateAnnotationEvent event, Emitter<CreateAnnotationsStates> state) async {
    state(CreateAnnotationsLoadingState());
    final annotation = await _createNewAnnotation(event.enterpriseId, event.annotation)?.catchError((e) {
      state(CreateAnnotationsErrorState());
      return null;
    });
    if (annotation != null) {
      state(CreateAnnotationsSuccessState(annotation));
    }
  }
}
