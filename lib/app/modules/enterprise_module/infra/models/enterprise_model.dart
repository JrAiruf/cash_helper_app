import 'dart:convert';

import '../../domain/entities/enterprise_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EnterpriseModel {
  String? enterpriseId;
  String? enterpriseCnpj;
  String? enterpriseName;
  String? enterpriseEmail;
  String? enterprisePassword;
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
    this.enterprisePassword,
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
      'enterprisePassword': enterprisePassword,
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
      enterprisePassword: map['enterprisePassword'],
      enterprisePhoneNumber: map['enterprisePhoneNumber'],
      enterpriseCode: map['enterpriseCode'],
      enterpriseCity: map['enterpriseCity'],
      enterpriseCep: map['enterpriseCep'],
      enterpriseState: map['enterpriseState'],
      enterpriseAddressStreet: map['enterpriseAddressStreet'],
      enterpriseAddressNumber: map['enterpriseAddressNumber'],
    );
  }
  static EnterpriseEntity toEntityData(EnterpriseModel enterpriseModel) {
    return EnterpriseEntity(
      enterpriseId: enterpriseModel.enterpriseId!,
      enterpriseCnpj: enterpriseModel.enterpriseCnpj!,
      enterpriseName: enterpriseModel.enterpriseName!,
      enterpriseEmail: enterpriseModel.enterpriseEmail!,
      enterprisePassword: enterpriseModel.enterprisePassword!,
      enterprisePhoneNumber: enterpriseModel.enterprisePhoneNumber!,
      enterpriseCode: enterpriseModel.enterpriseCode!,
      enterpriseCity: enterpriseModel.enterpriseCity!,
      enterpriseCep: enterpriseModel.enterpriseCep!,
      enterpriseState: enterpriseModel.enterpriseState!,
      enterpriseAddressStreet: enterpriseModel.enterpriseAddressStreet!,
      enterpriseAddressNumber: enterpriseModel.enterpriseAddressNumber!,
    );
  }

  static EnterpriseModel fromEntityData(EnterpriseEntity enterpriseEntity) {
    return EnterpriseModel(
      enterpriseId: enterpriseEntity.enterpriseId,
      enterpriseCnpj: enterpriseEntity.enterpriseCnpj,
      enterpriseName: enterpriseEntity.enterpriseName,
      enterpriseEmail: enterpriseEntity.enterpriseEmail,
      enterprisePassword: enterpriseEntity.enterprisePassword,
      enterprisePhoneNumber: enterpriseEntity.enterprisePhoneNumber,
      enterpriseCode: enterpriseEntity.enterpriseCode,
      enterpriseCity: enterpriseEntity.enterpriseCity,
      enterpriseCep: enterpriseEntity.enterpriseCep,
      enterpriseState: enterpriseEntity.enterpriseState,
      enterpriseAddressStreet: enterpriseEntity.enterpriseAddressStreet,
      enterpriseAddressNumber: enterpriseEntity.enterpriseAddressNumber,
    );
  }

  String toJson() => json.encode(toMap());

  factory EnterpriseModel.fromJson(String source) =>
      EnterpriseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
