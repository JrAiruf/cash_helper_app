import 'dart:convert';
import '../../domain/entities/payment_method_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentMethodModel {
  String? paymentMethodId;
  String? paymentMethodName;
  String? paymentMethodDescription;
  double? paymentMethodUsingRate;

  PaymentMethodModel({
    this.paymentMethodId,
    this.paymentMethodName,
    this.paymentMethodDescription,
    this.paymentMethodUsingRate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paymentMethodId': paymentMethodId,
      'paymentMethodName': paymentMethodName,
      'paymentMethodDescription': paymentMethodDescription,
      'paymentMethodUsingRate': paymentMethodUsingRate,
    };
  }

  factory PaymentMethodModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodModel(
      paymentMethodId: map['paymentMethodId'],
      paymentMethodName: map['paymentMethodName'],
      paymentMethodDescription: map['paymentMethodDescription'],
      paymentMethodUsingRate: map['paymentMethodUsingRate'],
    );
  }
  static PaymentMethodModel fromEntityData(
      PaymentMethodEntity paymentMethodEntity) {
    return PaymentMethodModel(
      paymentMethodId: paymentMethodEntity.paymentMethodId,
      paymentMethodName: paymentMethodEntity.paymentMethodName,
      paymentMethodDescription: paymentMethodEntity.paymentMethodDescription,
      paymentMethodUsingRate: paymentMethodEntity.paymentMethodUsingRate,
    );
  }

  static PaymentMethodEntity toEntityData(
      PaymentMethodModel paymentMethodModel) {
    return PaymentMethodEntity(
      paymentMethodId: paymentMethodModel.paymentMethodId,
      paymentMethodName: paymentMethodModel.paymentMethodName,
      paymentMethodDescription: paymentMethodModel.paymentMethodDescription,
      paymentMethodUsingRate: paymentMethodModel.paymentMethodUsingRate,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodModel.fromJson(String source) =>
      PaymentMethodModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
