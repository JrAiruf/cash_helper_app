import 'package:flutter_modular/flutter_modular.dart';

abstract class AnnotationsModule {
  static routes() => ModuleRoute(
        "/annotations-module",
        module: AnnotationModuleCore.instance,
      );
  static final binds = AnnotationModuleCore.instance.binds;
}

class AnnotationModuleCore extends Module {
  AnnotationModuleCore._();
  static final instance = AnnotationModuleCore._();
  @override
  List<Bind<Object>> get binds => [];
  @override
  List<ModularRoute> get routes => [];
}
