import 'package:cash_helper_app/app/modules/management_module/domain/usecases/get_operator_informations/iget_operators_informations.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';
import 'package:cash_helper_app/app/modules/user_module/domain/entities/operator_entity.dart';
import 'package:cash_helper_app/app/modules/user_module/infra/models/operator_model.dart';
import 'package:cash_helper_app/app/utils/tests/login_test_objects/login_test_objects.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';

class GetOperatorsInformationsMock implements IGetOperatorsInformations {
  GetOperatorsInformationsMock({required ManagementRepository repository})
      : _repository = repository;
  final ManagementRepository _repository;
  @override
  Future<List<OperatorEntity>>? call(String? enterpriseId) {
    throw UnimplementedError();
  }
}

void main() {
  final repository = ManagementRepoMock();
  final getOperatorInformations =
      GetOperatorsInformationsMock(repository: repository);
  group(
    'GetOperatorsInformation Usecase should',
    () {
      test(
        "Get a list of OperatorModel from repository and convert it into OperatorEntityList",
        () async {
          when(repository.getOperatorsInformation(any))
              .thenAnswer((_) async => <OperatorModel>[
                    LoginTestObjects.newOperatorModel,
                    LoginTestObjects.newOperatorModel,
                  ]);
                  final result = await getOperatorInformations("enterpriseId");
                  expect(result, isA<List<OperatorEntity>>());
                  expect(result?.first.operatorId, equals("q34u6hu1qeuyoio"));
        },
      );
    },
  );
}
