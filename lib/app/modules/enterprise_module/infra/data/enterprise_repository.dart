import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/enterprise_model.dart';

import '../models/payment_method_model.dart';

abstract class EnterpriseRepository {
  Future<dynamic>? createEnterpriseAccount(EnterpriseModel? enterpriseModel);
  Future<dynamic>? getEnterpriseByCode(String? enterpriseCode);
  Future<dynamic>? createPaymenMethod(PaymentMethodModel? paymentMethodModel, String? managerCode);
}
