import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EnterpriseModel {
  String? enterpriseId;
  String? enterpriseCnpj;
  String? enterpriseName;
  String? enterpriseEmail;
  String? enterprisePhoneNumber;
  String? enterpriseCode;
  String? enterpriseCity;
  String? enterpriseCep;
  String? enterpriseState;
  String? enterpriseAddressStreet;
  int? enterpriseAddressNumber;

  EnterpriseModel({
    this.enterpriseId,
    this.enterpriseCnpj,
    this.enterpriseName,
    this.enterpriseEmail,
    this.enterprisePhoneNumber,
    this.enterpriseCode,
    this.enterpriseCity,
    this.enterpriseCep,
    this.enterpriseState,
    this.enterpriseAddressStreet,
    this.enterpriseAddressNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'enterpriseId': enterpriseId,
      'enterpriseCnpj': enterpriseCnpj,
      'enterpriseName': enterpriseName,
      'enterpriseEmail': enterpriseEmail,
      'enterprisePhoneNumber': enterprisePhoneNumber,
      'enterpriseCode': enterpriseCode,
      'enterpriseCity': enterpriseCity,
      'enterpriseCep': enterpriseCep,
      'enterpriseState': enterpriseState,
      'enterpriseAddressStreet': enterpriseAddressStreet,
      'enterpriseAddressNumber': enterpriseAddressNumber,
    };
  }

  factory EnterpriseModel.fromMap(Map<String, dynamic> map) {
    return EnterpriseModel(
      enterpriseId: map['enterpriseId'],
      enterpriseCnpj: map['enterpriseCnpj'],
      enterpriseName: map['enterpriseName'],
      enterpriseEmail: map['enterpriseEmail'],
      enterprisePhoneNumber: map['enterprisePhoneNumber'],
      enterpriseCode: map['enterpriseCode'],
      enterpriseCity: map['enterpriseCity'],
      enterpriseCep: map['enterpriseCep'],
      enterpriseState: map['enterpriseState'],
      enterpriseAddressStreet: map['enterpriseAddressStreet'],
      enterpriseAddressNumber: map['enterpriseAddressNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EnterpriseModel.fromJson(String source) =>
      EnterpriseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
