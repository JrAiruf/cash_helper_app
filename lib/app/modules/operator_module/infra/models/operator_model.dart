// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import '../../domain/entities/operator_entity.dart';

class OperatorModel {
  String? operatorId;
  int? operatorNumber;
  String? operatorName;
  String? operatorEmail;
  String? operatorPassword;
  String? operatorCode;
  String? operatorOppening;
  String? operatorClosing;
  bool? operatorEnabled;
  String? operatorOcupation;
  OperatorModel({
    this.operatorId,
    this.operatorNumber,
    this.operatorName,
    this.operatorEmail,
    this.operatorPassword,
    this.operatorCode,
    this.operatorOppening,
    this.operatorClosing,
    this.operatorEnabled,
    this.operatorOcupation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'operatorId': operatorId,
      'operatorNumber': operatorNumber,
      'operatorName': operatorName,
      'operatorEmail': operatorEmail,
      'operatorPassword': operatorPassword,
      'operatorPassword': operatorCode,
      'operatorOppening': operatorOppening,
      'operatorClosing': operatorClosing,
      'operatorEnabled': operatorEnabled,
      'operatorOcupation': operatorOcupation,
    };
  }

  factory OperatorModel.fromMap(Map<String, dynamic> map) {
    return OperatorModel(
      operatorId: map['operatorId'],
      operatorNumber: map['operatorNumber'],
      operatorName: map['operatorName'],
      operatorEmail: map['operatorEmail'],
      operatorPassword: map['operatorPassword'],
      operatorCode: map['operatorCode'],
      operatorOppening: map['operatorOppening'],
      operatorClosing: map['operatorClosing'],
      operatorEnabled: map['operatorEnabled'],
      operatorOcupation: map['operatorOcupation'],
    );
  }

  static OperatorModel fromEntityData(OperatorEntity operator) {
    return OperatorModel(
      operatorId: operator.operatorId,
      operatorNumber: operator.operatorNumber,
      operatorName: operator.operatorName,
      operatorEmail: operator.operatorEmail,
      operatorPassword: operator.operatorPassword,
      operatorCode: operator.operatorCode,
      operatorOppening: operator.operatorOppening,
      operatorClosing: operator.operatorClosing,
      operatorEnabled: operator.operatorEnabled,
      operatorOcupation: operator.operatorOcupation,
    );
  }

  static OperatorEntity toEntityData(OperatorModel operator) {
    return OperatorEntity(
      operatorId: operator.operatorId,
      operatorNumber: operator.operatorNumber,
      operatorName: operator.operatorName,
      operatorEmail: operator.operatorEmail,
      operatorPassword: operator.operatorPassword,
      operatorCode: operator.operatorCode,
      operatorOppening: operator.operatorOppening,
      operatorClosing: operator.operatorClosing,
      operatorEnabled: operator.operatorEnabled,
      operatorOcupation: operator.operatorOcupation,
    );
  }

  String toJson() => json.encode(toMap());

  factory OperatorModel.fromJson(String source) =>
      OperatorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
