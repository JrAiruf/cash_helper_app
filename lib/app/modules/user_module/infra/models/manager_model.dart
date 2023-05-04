import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ManagerModel {
  String? managerId;
  String? managerName;
  String? managerEmail;
  String? managerPassword;
  String? managerCode;
  String? managerPhone;
  String? managerCpf;
  String? managerRg;
  String? businessPosition;

  ManagerModel({
    this.managerId,
    this.managerName,
    this.managerEmail,
    this.managerPassword,
    this.managerCode,
    this.managerPhone,
    this.managerCpf,
    this.managerRg,
    this.businessPosition,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'managerId': managerId,
      'managerName': managerName,
      'managerEmail': managerEmail,
      'managerPassword': managerPassword,
      'managerCode': managerCode,
      'managerPhone': managerPhone,
      'managerCpf': managerCpf,
      'managerRg': managerRg,
      'businessPosition': businessPosition,
    };
  }

  factory ManagerModel.fromMap(Map<String, dynamic> map) {
    return ManagerModel(
      managerId: map['managerId'],
      managerName: map['managerName'],
      managerEmail: map['managerEmail'],
      managerPassword: map['managerPassword'],
      managerCode: map['managerCode'],
      managerPhone: map['managerPhone'],
      managerCpf: map['managerCpf'],
      managerRg: map['managerRg'],
      businessPosition: map['businessPosition'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ManagerModel.fromJson(String source) =>
      ManagerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
