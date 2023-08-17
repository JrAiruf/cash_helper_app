import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/pendencies/generate_pendency/igenerate_pendency.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/adapters/pendency_adapter.dart';

import '../../../../infra/data/management_repository.dart';

class GeneratePendency implements IGeneratePendency {
  GeneratePendency({required ManagementRepository repository}) : _repository = repository;
  final ManagementRepository _repository;
  @override
  Future<PendencyEntity>? call(String enterpriseId, PendencyEntity pendency) async {
    final newPendency = await _repository.generatePendency(enterpriseId, pendency);
    if (newPendency != null) {
      return newPendency;
    } else {
      return PendencyEntity();
    }
  }
}
