import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/entities/annotation_entity.dart';
import 'package:cash_helper_app/app/modules/annotations_module/domain/usecases/search_annotations_by_client_address/isearch_annotations_by_client_address.dart';
import 'package:cash_helper_app/app/modules/annotations_module/infra/data/annotation_repository.dart';

import '../../../infra/models/annotation_model.dart';

class SearchAnnotationsByClientAddress
    implements ISearchAnnotationsByClientAddress {
  SearchAnnotationsByClientAddress({required AnnotationRepository repository})
      : _repository = repository;

  final AnnotationRepository _repository;
  final _dataVerifier = DataVerifier();
  @override
  Future<List<AnnotationEntity>?>? call(
      String? operatorId, String? clientAddress) async {
    if (_dataVerifier
        .validateInputData(inputs: [operatorId!, clientAddress!])) {
      final annotationModelList = await _repository
          .searchAnnotationsByClientAddress(operatorId, clientAddress);
      final annotationEntityList = annotationModelList
          ?.map((annotationModel) =>
              AnnotationModel.toEntityData(annotationModel))
          .toList();
      return annotationEntityList;
    } else {
      return [];
    }
  }
}
