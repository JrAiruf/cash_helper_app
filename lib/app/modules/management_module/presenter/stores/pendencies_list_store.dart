import 'package:cash_helper_app/app/modules/management_module/domain/entities/pendency_entity.dart';
import 'package:cash_helper_app/app/modules/management_module/domain/usecases/pendencies/get_all_pendencies/iget_all_pendencies.dart';
import 'package:flutter/cupertino.dart';

class PendenciesListStore extends ValueNotifier<List<PendencyEntity>> {
  PendenciesListStore({
    required IGetAllPendencies getAllPendencies,
  })  : _getAllPendencies = getAllPendencies,
        super([]);
  final IGetAllPendencies _getAllPendencies;

  final List<PendencyEntity> _pendencies = [];

  List<PendencyEntity> get pendencies => value;

  Future<void> getALlPendencies(String enterpriseId) async {
    final pendency = await _getAllPendencies(enterpriseId);
    value = _pendencies..addAll(pendency);
  }
}
