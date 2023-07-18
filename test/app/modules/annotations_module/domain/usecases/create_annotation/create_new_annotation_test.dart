import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/create_annotation/icreate_new_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/models/annotation_model.dart';
import 'package:cash_helper_app/app/utils/tests/annotations_test_objects/test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../../mocks/mocks.dart';

class CreateNewAnnotationMock implements ICreateNewAnnotation {
  CreateNewAnnotationMock({required AnnotationRepository repository}) : _repository = repository;

  final AnnotationRepository _repository;
  @override
  Future<AnnotationEntity>? call(String? enterpriseId, AnnotationEntity? annotation) async {
    final annotationModel = AnnotationModel.fromEntityData(annotation!);
    final repositoryAnnotation = await _repository.createAnnotation(enterpriseId!, annotationModel);
    return AnnotationModel.toEntityData(repositoryAnnotation!);
  }
}

void main() {
  final repository = AnnotationRepo();
  final createAnnotation = CreateNewAnnotationMock(repository: repository);
  test(
    "CreateNewAnnotation Usecase should create a new Annotation and return an AnnotationEntity object",
    () async {
      when(repository.createAnnotation(any, any)).thenAnswer((_) async => AnnotationsTestObjects.repositoryAnnotation);
      final createdAnnotation = await createAnnotation("enterpriseId", AnnotationsTestObjects.newAnnotation);
      expect(createdAnnotation, isA<AnnotationEntity>());
      expect(createdAnnotation?.annotationId != null, equals(true));
    },
  );
}
