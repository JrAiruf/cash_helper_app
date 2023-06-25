import 'package:cash_helper_app/app/modules/user_module/domain/usecases/open_operator_cash/iopen_operator_cash.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/data/operator_repository.dart';

class OpenOperatorCash implements IOpenOperatorCash {
  OpenOperatorCash({required OperatorRepository repository})
      : _repository = repository;

  final OperatorRepository _repository;
  @override
  Future<void> call(
          String enterpriseId, String operatorId, String oppeningTime) async =>
      await _repository.openOperatorCash(
          enterpriseId, operatorId, oppeningTime);
}
