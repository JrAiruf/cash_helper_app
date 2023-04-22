import 'package:cash_helper_app/app/modules/annotations_module/domain/contract/annotation_usecases.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/annotation_usecases_impl.dart';
import 'package:cash_helper_app/app/modules/annotations_module/external/annotations_database.dart';
import 'package:cash_helper_app/app/modules/annotations_module/external/data/application_annotations_database.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/repository/annotation_repository_impl.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotations_list_store.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotations_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uuid/uuid.dart';

import '../presenter/pages/create_annotations_page.dart';

abstract class AppAnnotationModule {
  static routes() => ModuleRoute(
        "/annotations-module",
        module: AnnotationModule.instance,
        transition: TransitionType.fadeIn,
      );
  static final module = AnnotationModule.instance;
}

class AnnotationModule extends Module {
  AnnotationModule._();
  static final instance = AnnotationModule._();
  @override
  List<Bind<Object>> get binds => bindsList;
  @override
  List<ModularRoute> get routes => routesList;

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
      (i) => AnnotationRepositoryImpl(
        datasource: i(),
      ),
    ),
    Bind<AnnotationUsecases>(
      (i) => AnnotationUsecasesImpl(
        repository: i(),
      ),
    ),
    Bind<AnnotationsListStore>(
      (i) => AnnotationsListStore(
        usecases: i(),
      ),
    ),
    Bind<AnnotationStore>(
      (i) => AnnotationStore(
        usecases: i(),
      ),
    ),
  ];

  final routesList = <ModularRoute>[
    ChildRoute(
      "/",
      child: (_, args) =>const CreateAnnotationsPage(),
    ),
    ChildRoute(
      "/name",
      child: (_, args) => Container(),
    ),
  ];
}
