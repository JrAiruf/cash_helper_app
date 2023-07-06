import 'package:cash_helper_app/app/modules/login_module/domain/usecases/get_all_operators/iget_all_operators.dart';
import 'package:cash_helper_app/app/modules/login_module/infra/data/login_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';

class GetAllOperatorsMock implements IGetAllOperators {
  GetAllOperatorsMock({required LoginRepository repository}) : _repository = repository;

  final LoginRepository _repository;
  @override
  Future<List<OperatorEntity>>? call(String? enterpriseId) async {
    final operatorsModelList = await _repository.getAllOperators(enterpriseId!) as List;
    return operatorsModelList.map((operatorModel) => OperatorModel.toEntityData(operatorModel)).toList();
  }
}

void main() {
  final repository = LoginRepositoryMock();
  final getAllOperators = GetAllOperatorsMock(repository: repository);
  test(
    "GetAllOperators should return a List<OperatorEntity>",
    () async {
      when(repository.getAllOperators(any)).thenAnswer(
        (_) async => [
          LoginTestObjects.newOperatorModel,
          LoginTestObjects.newOperatorModel,
        ],
      );
      final result = await getAllOperators("enterpriseId");
      expect(result, isA<List<OperatorEntity>>());
    },
  );
}
