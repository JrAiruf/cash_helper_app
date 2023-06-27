import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/usecases/pendencies/generate_pendency/igenerate_pendency.dart';

class PendencyStore extends ValueNotifier<List<PendencyEntity>> {
  PendencyStore({
    required IGeneratePendency generatePendency,
  })  : _generatePendency = generatePendency,
        super([]);
  final IGeneratePendency _generatePendency;

  final List<PendencyEntity> _pendencies = [];

  List<PendencyEntity> get pendencies => value;

  Future<void> generatePendency(String enterpriseId, String operatorId, String annotationId) async {
    final pendency = await _generatePendency(enterpriseId, operatorId, annotationId);
    value = _pendencies
      ..add(pendency!);
  }
}
