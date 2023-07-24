import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_annotations/iget_all_annotations.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_pending_annotations/get_all_pending_annotations.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/get_all_pending_annotations/iget_all_pending_annotations.dart';
import 'package:cash_helper_app/app/modules/annotations_module/external/annotations_database.dart';
import 'package:cash_helper_app/app/modules/annotations_module/external/data/application_annotations_database.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/repository/annotation_repository_impl.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/blocs/annotations_bloc/annotations_bloc_binds.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/controllers/annotations_controller.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/pages/annotation_page.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotations_list_store.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/annotations_store.dart';
import 'package:cash_helper_app/app/modules/annotations_module/presenter/stores/pending_annotations_list_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uuid/uuid.dart';
import '../domain/usecases/create_annotation/create_new_annotation.dart';
import '../domain/usecases/create_annotation/icreate_new_annotation.dart';
import '../domain/usecases/delete_annotation/delete_annotation.dart';
import '../domain/usecases/delete_annotation/idelete_annotation.dart';
import '../domain/usecases/finish_annotation/finish_annotation.dart';
import '../domain/usecases/finish_annotation/ifinish_annotation.dart';
import '../domain/usecases/get_all_annotations/get_all_annotations.dart';
import '../domain/usecases/get_annotation_by_id/get_annotation_by_id.dart';
import '../domain/usecases/get_annotation_by_id/iget_annotation_by_id.dart';
import '../domain/usecases/search_annotations_by_client_address/isearch_annotations_by_client_address.dart';
import '../domain/usecases/search_annotations_by_client_address/search_annotations_by_client_address.dart';
import '../domain/usecases/update_annotation/iupdate_annotation.dart';
import '../domain/usecases/update_annotation/update_annotation.dart';
import '../presenter/pages/annotations_list_page.dart';
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
        dataVerifier: i(),
      ),
    ),
    Bind<ICreateNewAnnotation>(
      (i) => CreateNewAnnotation(
        repository: i(),
      ),
    ),
    Bind<IDeleteAnnotation>(
      (i) => DeleteAnnotation(
        repository: i(),
      ),
    ),
    Bind<IFinishAnnotation>(
      (i) => FinishAnnotation(
        repository: i(),
      ),
    ),
    Bind<IGetAllAnnotations>(
      (i) => GetAllAnnotations(
        repository: i(),
      ),
    ),
    Bind<IGetAllPendingAnnotations>(
      (i) => GetAllPendingAnnotations(
        repository: i(),
      ),
    ),
    Bind<IGetAnnotationById>(
      (i) => GetAnnotationById(
        repository: i(),
      ),
    ),
    Bind<ISearchAnnotationsByClientAddress>(
      (i) => SearchAnnotationsByClientAddress(
        repository: i(),
      ),
    ),
    Bind<IUpdateAnnotation>(
      (i) => UpdateAnnotation(
        repository: i(),
      ),
    ),
    Bind<AnnotationsListStore>(
      (i) => AnnotationsListStore(
        getAllAnnotations: i(),
        searchAnnotationsByClientAddress: i(),
      ),
    ),
    Bind<PendingAnnotationsListStore>(
      (i) => PendingAnnotationsListStore(
        getAllPendingAnnotations: i(),
      ),
    ),
    Bind<AnnotationsController>(
      (i) => AnnotationsController(),
    ),
    Bind<AnnotationStore>(
      (i) => AnnotationStore(
        createNewAnnotation: i(),
        getAnnotationById: i(),
        updateAnnotation: i(),
        finishAnnotation: i(),
        deleteAnnotation: i(),
      ),
    ),
    ...AnnotationsBlocBinds.binds,
  ];

  final routesList = <ModularRoute>[
    ChildRoute(
      "/:enterpriseId",
      child: (_, args) => CreateAnnotationsPage(operatorEntity: args.data),
    ),
    ChildRoute(
      "/annotation-page/:enterpriseId",
      child: (_, args) => AnnotationPage(),
    ),
    ChildRoute(
      "/annotations-list-page/:enterpriseId",
      child: (_, args) => AnnotationsListPage(operatorEntity: args.data),
    ),
  ];
}
