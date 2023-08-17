import 'package:cash_helper_app/app/modules/annotations_module/presenter/blocs/bloc/get_annotations_bloc.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/blocs/create_annotations_bloc/create_annotations_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AnnotationsBlocBinds {
  static final binds = <Bind>[
    Bind.singleton<CreateAnnotationsBloc>((i)=> CreateAnnotationsBloc(createNewAnnotation: i())),
    Bind.singleton<GetAnnotationsBloc>((i)=> GetAnnotationsBloc(getAllAnnotations: i())),
  ];
}
