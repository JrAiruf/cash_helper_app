import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/create_annotation/icreate_new_annotation.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../../mocks/mocks.dart';

class CreateNewAnnotationMock implements ICreateNewAnnotation {
  CreateNewAnnotationMock({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  @override
  Future? call(
      String enterpriseId, String operatorId, AnnotationEntity annotation) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

void main() {
  final repository = AnnotationRepo();
  final createAnnotation = CreateNewAnnotationMock(repository: repository);
  group(
    "CreateNewAnnotation Usecase should",
    () {
      test(
        "Create a new Annotation and return an AnnotationEntity object",
        () async {
          // TODO: Implement test
        },
      );
      test(
        'Fail to create an annotation',
        () async {
          // TODO: Implement test
        },
      );
    },
  );
}
