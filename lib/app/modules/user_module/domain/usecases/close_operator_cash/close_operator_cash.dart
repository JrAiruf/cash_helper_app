import '../../../infra/data/operator_repository.dart';
import 'iclose_operator_cash.dart';

class CloseOperatorCash implements ICloseOperatorCash {
CloseOperatorCash({required OperatorRepository repository})
      : _repository = repository;

  final OperatorRepository _repository;
  @override
  Future<void> call(String enterpriseId, String operatorId, String closingTime) async =>
      await _repository.openOperatorCash(
          enterpriseId, operatorId, closingTime);
}