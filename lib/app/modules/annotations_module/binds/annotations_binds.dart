import 'package:flutter_modular/flutter_modular.dart';

abstract class AnnotationsModuleBinds {
  static routes() => ModuleRoute(
        "/annotations-module",
        module: AnnotationModule.instance,
      );
  static final binds = AnnotationModule.instance.binds;
}

class AnnotationModule extends Module {
  AnnotationModule._();
  static final instance = AnnotationModule._();
  @override
  List<Bind<Object>> get binds => [];
  @override
  List<ModularRoute> get routes => [];
}
