import 'package:cash_helper_app/app/modules/annotations_module/presenter/blocs/annotations_bloc/annotations_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AnnotationsBlocBinds {
  static final binds = <Bind>[
    Bind<AnnotationsBloc>((i)=> AnnotationsBloc(createNewAnnotation: i())),
  ];
}
