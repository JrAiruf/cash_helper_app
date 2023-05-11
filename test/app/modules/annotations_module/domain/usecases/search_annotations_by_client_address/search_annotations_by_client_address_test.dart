import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/search_annotations_by_client_address/isearch_annotations_by_client_address.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/models/annotation_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import '../create_annotation/create_annotation_test.dart';


class SearchMock implements ISearchAnnotationsByClientAddress {
   SearchMock({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  final _dataVerifier = DataVerifier();
  @override
  Future? call(String? operatorId, String? clientAddress) async {
  if(_dataVerifier.validateInputData(inputs:[operatorId!,clientAddress!])){
    final annotationModelList = await _repository
        .searchAnnotationsByClientAddress(operatorId, clientAddress);
    final annotationEntityList = annotationModelList
        ?.map(
            (annotationModel) => AnnotationModel.toEntityData(annotationModel))
        .toList();
    return annotationEntityList;
        } else {
          return [];
        }
  }
}
void main() {
  final repository = AnnotationRepo();
  final createAnnotation = CreateAnnotationUsecaseMock(repository: repository);
  final searchAnnotationsByClientAddress = SearchMock(repository: repository);
  final newAnnotation = AnnotationEntity(
      annotationClientAddress: "Andorinhas 381",
      annotationConcluied: false,
      annotationPaymentMethod: "Dinheiro",
      annotationReminder: "No Reminder",
      annotationSaleDate: "Data Atual",
      annotationSaleTime: "Hora Atual",
      annotationSaleValue: "1455,67");
  group(
    "SearchAnnotationsByClientAddress Function Should",
    () {
      test(
        "Return an annotation object from repository, in wich annotationClientAddress property matches with the given text",
        () async {
          when(repository.createAnnotation(any, any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          expect(createdAnnotation?.annotationClientAddress,
              equals("Andorinhas 381"));
          when(repository.searchAnnotationsByClientAddress(any, any))
              .thenAnswer((_) async => [repositoryAnnotation]);
          final suggestedAnnotionAddressList = await               searchAnnotationsByClientAddress('operatorId', "Andorinhas");
          expect(suggestedAnnotionAddressList, isA<List<AnnotationEntity>>());
          expect(suggestedAnnotionAddressList?.isNotEmpty, equals(true));
        },
      );
      test(
        "Fail returning an annotation from result search",
        () async {
          when(repository.createAnnotation(any, any, any))
              .thenAnswer((_) async => repositoryAnnotation);
          final createdAnnotation =
              await createAnnotation("operatorId", newAnnotation);
          expect(createdAnnotation, isA<AnnotationEntity>());
          expect(createdAnnotation?.annotationClientAddress,
              equals("Andorinhas 381"));
          when(repository.searchAnnotationsByClientAddress(any, any))
              .thenAnswer((_) async => [repositoryAnnotation]);
          final suggestedAnnotionAddressList =
              await searchAnnotationsByClientAddress("operatorId", "");
          expect(suggestedAnnotionAddressList?.isEmpty, equals(true));
        },
      );
    },
  );
}