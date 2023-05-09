import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/external/data/application_enterprise_database.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/data/enterprise_repository.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/enterprise_model.dart';

import '../models/payment_method_model.dart';

class EnterpriseRepositoryImpl implements EnterpriseRepository {
  EnterpriseRepositoryImpl({
    required ApplicationEnterpriseDatabase database,
    required DataVerifier dataVerifier,
  })  : _database = database,
        _dataVerifier = dataVerifier;

  final ApplicationEnterpriseDatabase _database;
  final DataVerifier _dataVerifier;

  @override
  Future<EnterpriseModel?>? createEnterpriseAccount(
      EnterpriseModel? enterpriseModel) async {
    if (_dataVerifier.objectVerifier(object: enterpriseModel?.toMap() ?? {})) {
      final enterpriseDatabaseMap =
          await _database.createEnterpriseAccount(enterpriseModel?.toMap());
      return EnterpriseModel.fromMap(enterpriseDatabaseMap);
    } else {
      return null;
    }
  }

  @override
  Future<EnterpriseModel?>? getEnterpriseByCode(String? enterpriseCode) async {
    if (_dataVerifier.validateInputData(inputs: [enterpriseCode])) {
      final enterpriseDatabaseMap =
          await _database.getEnterpriseByCode(enterpriseCode);
      return EnterpriseModel.fromMap(enterpriseDatabaseMap);
    } else {
      return null;
    }
  }
  
   @override
  Future? createPaymenMethod(PaymentMethodModel? paymentMethodModel, String? managerCode) {
    // TODO: implement createPaymenMethod
    throw UnimplementedError();
  }
}
