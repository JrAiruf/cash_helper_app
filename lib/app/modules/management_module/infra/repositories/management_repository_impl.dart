import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/payment_method_model.dart';
import 'package:cash_helper_app/app/modules/management_module/external/management_database.dart';
import 'package:cash_helper_app/app/modules/management_module/infra/data/management_repository.dart';

import '../../../../helpers/data_verifier.dart';
import '../../../user_module/infra/models/operator_model.dart';

class ManagementRepositoryImpl implements ManagementRepository {
  ManagementRepositoryImpl({
    required ManagementDatabase database,
    required DataVerifier dataVerifier,
  })  : _database = database,
        _dataVerifier = dataVerifier;
  final ManagementDatabase _database;
  final DataVerifier _dataVerifier;

  @override
  Future<List<OperatorModel>>? getOperatorsInformations(
      String? enterpriseId) async {
    final operatorsModelList = <OperatorModel>[];
    if (_dataVerifier.validateInputData(inputs: [enterpriseId])) {
      final databaseOperatorsMapsList =
          await _database.getOperatorInformations(enterpriseId) ?? [];
      for (var operatorMap in databaseOperatorsMapsList) {
        final operatorModel = OperatorModel.fromMap(operatorMap);
        operatorsModelList.add(operatorModel);
      }
    }
    return operatorsModelList;
  }

  @override
  Future? createNewPaymentMethod(String enterpriseId, PaymentMethodModel paymentMethod) {
    // TODO: implement createNewPaymentMethod
    throw UnimplementedError();
  }
}