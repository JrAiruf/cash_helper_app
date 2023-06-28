import 'package:cash_helper_app/app/modules/management_module/domain/usecases/pendencies/generate_pendency/igenerate_pendency.dart';

class PendencyStore {
  PendencyStore({required IGeneratePendency generatePendency}) : _generatePendency = generatePendency;
  final IGeneratePendency _generatePendency;

  Future<void> generatePendency(String enterpriseId, String operatorId, String annotationId) async {
    await _generatePendency(enterpriseId, operatorId, annotationId);
  }
}
