import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/pendencies/generate_pendency/igenerate_pendency.dart';

import '../../../../infra/data/management_repository.dart';

class GeneratePendency implements IGeneratePendency {
  GeneratePendency({required ManagementRepository repository}) : _repository = repository;
  final ManagementRepository _repository;
 @override
  Future<PendencyEntity>? call(String enterpriseId, String operatorId, String annotationId) async {
    final pendency = await _repository.generatePendency(enterpriseId, operatorId, annotationId);
    if (pendency != null) {
      return pendency;
    } else {
      return PendencyEntity();
    }
  }
}
