import 'package:cash_helper_app/app/helpers/data_verifier.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/external/data/application_enterprise_database.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/data/enterprise_repository.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/enterprise_model.dart';

class EnterpriseRepositoryImpl implements EnterpriseRepository {
  EnterpriseRepositoryImpl({
    required ApplicationEnterpriseDatabase database,
    required DataVerifier dataVerifier,
  }) :
   _database = database,
   _dataVerifier = dataVerifier;

  final ApplicationEnterpriseDatabase _database;
  final DataVerifier _dataVerifier;
  @override
  Future? createEnterpriseAccount(EnterpriseModel? enterpriseModel) {
    // TODO: implement call
    throw UnimplementedError();
  }

  @override
  Future getEnterpriseByCode(String? enterpriseCode) {
    // TODO: implement getEnterpriseByCode
    throw UnimplementedError();
  }
}
