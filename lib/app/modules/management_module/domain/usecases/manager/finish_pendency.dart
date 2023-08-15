import 'package:cash_helper_app/app/modules/management_module/domain/usecases/manager/ifinish_pendency.dart';

import '../../../infra/data/management_repository.dart';

class FinishPendency implements IFinishPendency {
  FinishPendency({required ManagementRepository repository}) : _repository = repository;

  final ManagementRepository _repository;
    @override
  Future<void> call(String enterpriseId, String pendencyId) async {
    await _repository.finishPendency(enterpriseId, pendencyId);
  }
}
