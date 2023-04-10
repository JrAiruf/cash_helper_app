import 'package:cash_helper_app/app/modules/annotations_module/external/annotations_database.dart';
import 'package:cash_helper_app/app/modules/annotations_module/external/data/application_annotations_database.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/repository/annotation_repository_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uuid/uuid.dart';

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

  final bindsList = <Bind>[
    Bind<Uuid>(
      (i) => const Uuid(),
    ),
    Bind<ApplicationAnnotationDatabase>(
      (i) => AnnotationsDatabase(
        database: i(),
        uuidGenertor: i(),
      ),
    ),
    Bind<AnnotationRepository>(
      (i) => AnnotationRepositoryImpl(datasource: i(),
      ),
    ),
  ];
}
