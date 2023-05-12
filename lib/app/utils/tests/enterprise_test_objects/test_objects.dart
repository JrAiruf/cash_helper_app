import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/enterprise_model.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/payment_method_model.dart';

import '../../../modules/enterprise_module/domain/entities/payment_method_entity.dart';

class EnterpriseTestObjects {
  static Map<String, dynamic> enterpriseMap = {
    'enterpriseCnpj': "00000000000122",
    'enterpriseName': "PrimeSoftware",
    'enterpriseEmail': "prime@email.com",
    'enterprisePassword': "12345678",
    'enterprisePhoneNumber': "3835274625",
    'enterpriseCode': "537ujs02k",
    'enterpriseCity': "Turmalina",
    'enterpriseCep': "39660000",
    'enterpriseState': "Minas Gerais",
    'enterpriseAddressStreet': "Andorinhas",
    'enterpriseAddressNumber': 381
  };

  static final enterpriseModel = EnterpriseModel(
      enterpriseCnpj: "00000000000122",
      enterpriseName: "PrimeSoftware",
      enterpriseEmail: "prime@email.com",
      enterprisePassword: "12345678",
      enterprisePhoneNumber: "3835274625",
      enterpriseCode: "537ujs02k",
      enterpriseCity: "Turmalina",
      enterpriseCep: "39660000",
      enterpriseState: "Minas Gerais",
      enterpriseAddressStreet: "Andorinhas",
      enterpriseAddressNumber: 381);

  static final enterpriseEntity = EnterpriseEntity(
      enterpriseCnpj: "00000000000122",
      enterpriseName: "PrimeSoftware",
      enterpriseEmail: "prime@email.com",
      enterprisePassword: "12345678",
      enterprisePhoneNumber: "3835274625",
      enterpriseCode: "537ujs02k",
      enterpriseCity: "Turmalina",
      enterpriseCep: "39660000",
      enterpriseState: "Minas Gerais",
      enterpriseAddressStreet: "Andorinhas",
      enterpriseAddressNumber: 381);

}

class PaymentMethodTestObjects {

  static final paymentMethodModel = PaymentMethodModel(
    paymentMethodId: "aldql34hlaky5qi24nlnalnaljq4nal4",
    paymentMethodDescription:
        "Pagamentos a vista. Inclui Percentual de desconto",
    paymentMethodName: "Dinheiro",
    paymentMethodUsingRate: 34.7,
  );
  static final paymentMethodEntity = PaymentMethodEntity(
    paymentMethodId: "aldql34hlaky5qi24nlnalnaljq4nal4",
    paymentMethodDescription:
        "Pagamentos a vista. Inclui Percentual de desconto",
    paymentMethodName: "Dinheiro",
    paymentMethodUsingRate: 34.7,
  );
  static final Map<String, dynamic> paymentMethodMap = {
    "paymentMethodId": "aldql34hlaky5qi24nlnalnaljq4nal4",
    "paymentMethodDescription":
        "Pagamentos a vista. Inclui Percentual de desconto",
    "paymentMethodName": "Dinheiro",
    "paymentMethodUsingRate": 34.7,
  };
  static final newPaymentMethodModel = PaymentMethodModel(
    paymentMethodDescription:
        "Pagamentos a vista. Inclui Percentual de desconto",
    paymentMethodName: "Dinheiro",
    paymentMethodUsingRate: 34.7,
  );
  static final newPaymentMethodEntity = PaymentMethodEntity(
    paymentMethodDescription:"Pagamentos a vista. Inclui Percentual de desconto",
    paymentMethodName: "Dinheiro",
    paymentMethodUsingRate: 34.7,
  );
  static final Map<String, dynamic> newPaymentMethodMap = {
    "paymentMethodDescription":
        "Pagamentos a vista. Inclui Percentual de desconto",
    "paymentMethodName": "Dinheiro",
    "paymentMethodUsingRate": 34.7,
  };
}
