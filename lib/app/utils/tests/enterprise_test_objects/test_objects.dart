import 'package:cash_helper_app/app/modules/enterprise_module/domain/entities/enterprise_entity.dart';
import 'package:cash_helper_app/app/modules/enterprise_module/infra/models/enterprise_model.dart';

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
